//
//  MapView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//  Description: 제주도의 지도를 검색하고 조회하는 뷰

import SwiftUI
import MapKit
import CoreLocation


struct MapView: View {
    
    // @@ === Map Field === @@
    // 맵의 초기 띄워줄 위도, 경도, 줌을 설정하는 position으로 제주도 가운데인 한라산 봉우리를 기본값으로 찍어놓음
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.361722862714, longitude: 126.53366495424248),
        span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.6)
    ))
    @State private var selectedResult: MKMapItem? // 선택된 마커를 알고있을 변수
    @State var touristResult: [TouristDataModel] = [] // 관광지, 쇼핑 검색 결과
    @State var restaurantResult: [RestaurantDataModel] = [] // 식당 검색 결과
    @State var toiletResult: [ToiletDataModel] = [] // 화장실 검색 결과
    
    // @@ === View Field === @@
    @State private var searchText: String = "" // 검색 텍스트필드
    @State private var showActionButtons = false
    @State private var showMenu = false
    
    
    // @@ === BottomSheet Field === @@
    @State private var showSheet: Bool = false // sheet status
    @State private var selectedTitle: String = "" // 선택된 마커 이름을 담을 변수
    // 식당
    @State private var selectedFoodCategory: String = "" // 카테고리 담을 변수
    @State private var selectedImages: String = "" // 선택된 마커가 가진 이미지를 담을 변수
    // 관광지
    
    // 화장실
    @State private var selectedToiletAddress: String = ""
    @State private var selectedToiletCount1: String = ""
    @State private var selectedToiletCount2: String = ""
    @State private var selectedToiletCount3: String = ""
    @State private var selectedToiletTime: String = ""
    
    
    
    // @@ === Constructor === @@
    var data = MapDataLoad() // json데이터 불러오기 및 검색기능이 있는 class 생성자 연돈
    
    
    var body: some View {
        ZStack {
            Map(position: $position, selection: $selectedResult) {
                // 관광지 어노테이션
                ForEach(touristResult, id: \.self) {  tour in
                    Annotation(tour.title, coordinate: CLLocationCoordinate2D(latitude: tour.latitude, longitude: tour.longitude)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.background)
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(.secondary, lineWidth: 2)
                            if tour.category == "관광지"  && !tour.tag.contains("반려동물"){
                                Image(systemName: "flag")
                                    .padding(5)
                                    .frame(width: 16, height: 16)
                            } else if tour.category == "쇼핑" {
                                Image(systemName: "bag")
                                    .padding(5)
                                    .frame(width: 16, height: 16)
                            } else {
                                Image(systemName: "dog")
                                    .padding(5)
                                    .frame(width: 16, height: 16)
                            }
                        }
                        .onTapGesture {
                            selectedTitle = tour.title
                        }
                    }
                }
                
                // 음식점 어노테이션
                ForEach(restaurantResult, id: \.self) {  restaurant in
                    Annotation(restaurant.사업장명, coordinate: CLLocationCoordinate2D(latitude: Double(restaurant.lat) ?? 37.5665, longitude: Double(restaurant.lng) ?? 126.9780)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.background)
                            //                            RoundedRectangle(cornerRadius: 2)
                            //                                .stroke(.secondary, lineWidth: 2)
                            Image(systemName: "fork.knife.circle")
                                .padding(5)
                                .frame(width: 16, height: 16)
                        }
                        .onTapGesture { // 마커 클릭시 이벤트
                            selectedImages = restaurant.images // 이미지 상태 업데이트
                            selectedTitle = restaurant.사업장명
                            selectedFoodCategory = restaurant.foodCategory
                            //                            print(selectedImages)
                            showSheet.toggle() // Sheet 표시를 위한 상태 변경
                        }
                        .sheet(isPresented: $showSheet) {
                            RestaurantSheetView(title: $selectedTitle, category: $selectedFoodCategory, images: $selectedImages)
                                .presentationDetents([.height(300), .large]) // medium 또는 large 크기로 조절 가능
                                .presentationDragIndicator(.visible) // 사용자가 드래그 가능함을 나타내는 인디케이터 보이기
                        }
                    }
                    
                }
                
                // 화장실 어노테이션
                ForEach(toiletResult, id: \.self) {  toilet in
                    Annotation(toilet.화장실명, coordinate: CLLocationCoordinate2D(latitude: Double(toilet.WGS84위도) ?? 37.5665, longitude: Double(toilet.WGS84경도) ?? 126.9780)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.background)
                            //                            RoundedRectangle(cornerRadius: 2)
                            //                                .stroke(.secondary, lineWidth: 2)
                            Image(systemName: "toilet")
                                .padding(5)
                                .frame(width: 16, height: 16)
                        }
                        .onTapGesture { // 마커 클릭시 이벤트
                            selectedTitle = toilet.화장실명
                            
                            showSheet.toggle() // Sheet 표시를 위한 상태 변경
                        }
                        .sheet(isPresented: $showSheet) {
                            ToiletSheet(title: $selectedTitle)
                                .presentationDetents([.height(300)]) // medium 또는 large 크기로 조절 가능
                            //                                .presentationDragIndicator(.visible) // 사용자가 드래그 가능함을 나타내는 인디케이터 보이기
                        }
                        
                    }
                }
            }
            
            
            
            .mapControls() { // AppleMap 기본 버튼 생성
                MapControllView()
            }
            
            
            // 맵 위에 서치바, 카테고리 버튼들이 있는 VStack
            VStack (alignment: .leading) {
                MapSearchBarView(searchText: $searchText, restaurantResult: $restaurantResult, touristResult: $touristResult, toiletResult: $toiletResult)
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 30))
                
                // 나중에 struct로 따로 분리할 필요가 있음
                HStack {
                    Button(action: {
                        toiletResult = []
                        touristResult = []
                        restaurantResult = []
                        if let results = data.searchRestaurants(searchText: "연돈") {
                            restaurantResult.append(contentsOf: results)  // 배열에 다른 배열의 내용을 추가
                        }
                    }) {
                        Image(systemName: "fork.knife")
                    }
                    .frame(width: 38, height: 30)
                    .background(.white)
                    .cornerRadius(10) // 테두리 둥글게
                    .padding(10)
                    
                    Button(action: {
                        toiletResult = []
                        touristResult = []
                        restaurantResult = []
                        
                        if let results = data.searchToilets() {
                            toiletResult.append(contentsOf: results)  // 배열에 다른 배열의 내용을 추가
                            
                        }
                    }) {
                        Image(systemName: "figure.dress.line.vertical.figure")
                    }
                    .frame(width: 38, height: 30)
                    .background(.white)
                    .cornerRadius(10) // 테두리 둥글게
                    .padding(10)
                    
                    Button(action: {
                        toiletResult = []
                        touristResult = []
                        restaurantResult = []
                        
                        if let results = data.searchAnimalData() {
                            touristResult.append(contentsOf: results)
                        }
                    }) {
                        Image(systemName: "dog")
                    }
                    .frame(width: 38, height: 30)
                    .background(.white)
                    .cornerRadius(10) // 테두리 둥글게
                    .padding(10)
                    
                    
                    Button(action: {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "fork.knife")
                    }
                    .frame(width: 38, height: 30)
                    .background(.white)
                    .cornerRadius(10) // 테두리 둥글게
                    .padding(10)
                    
                    
                    //                                .onTapGesture {
                    //                                    // 원형 메뉴 영역 내 클릭시 메뉴 유지
                    //                                }
                    //                                .animation(.easeInOut, value: showMenu)
                    
                    
                    
                }
                
                Spacer()
            }
            // 원형 메뉴 도형 및 텍스트 옵션
            // 조건부로 메뉴를 오버레이
            //        if showMenu {
            //            //                MapActionButton()
            //            Circle()
            //                .frame(width: 100, height: 100)
            //                .foregroundColor(Color.gray.opacity(0.3))
            //                .overlay(
            //                    VStack {
            //                        Button(action: {
            //                            print("옵션 1 동작")
            //                        }) {
            //                            Text("옵션 1")
            //                        }
            //
            //                        Button(action: {
            //                            print("옵션 2 동작")
            //                        }) {
            //                            Text("옵션 2")
            //                        }
            //
            //                        Button(action: {
            //                            print("옵션 3 동작")
            //                        }) {
            //                            Text("옵션 3")
            //                        }
            //                    }
            //                        .foregroundColor(.black)
            //                )
            //                .onTapGesture {
            //                    // 원형 메뉴 영역 내 클릭시 메뉴 유지
            //                }
            //                .position(x: UIScreen.main.bounds.width / 6.8, y: UIScreen.main.bounds.height / 5.5) // 화면 중앙에 표시
            //        }
            //
            //            .onTapGesture {
            //                showMenu = false
            //
            //            }
        }

    }
    
    
} // End

//#Preview {
//    MapView()
//}
//
