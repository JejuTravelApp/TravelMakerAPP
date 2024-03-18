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
    @FocusState private var isTextFieldFocused: Bool // FocusState를 부모 뷰에서 관리
    
    
    // @@ === BottomSheet Field === @@
    @State private var showSheet: Bool = false // sheet status
    @State private var selectedTitle: String = "" // 선택된 마커 이름을 담을 변수
    // 식당
    @State private var selectedFoodCategory: String = "" // 카테고리 담을 변수
    @State private var selectedImages: String = "" // 선택된 마커가 가진 이미지를 담을 변수
    // 관광지
    
    // 화장실
    @State private var selectedToiletAddress: String = "" // 주소
    @State private var selectedToiletCount1: Int = 0 // 남성용 장애인 대변기수
    @State private var selectedToiletCount2: Int = 0 // 남성용 장애인 소변기수
    @State private var selectedToiletCount3: Int = 0 // 여성용 장애인 대변기수
    @State private var selectedToiletTime: String = "" // 화장실 개방시간
    @State private var selectedToiletIsBell: String = "" // 비상벨 유무
    @State private var selectedToiletBellSpot: String = "" // 비상벨 장소
    @State private var selectedToiletIsBaby: String = "" // 귀저기교환대장소 유무
    @State private var selectedToiletBabySpot: String = "" // 귀저기교환대장소
    
    
    
    // @@ === Constructor === @@
    var data = MapDataLoad() // json데이터 불러오기 및 검색기능이 있는 class 생성자 연돈
    
    
    var body: some View {
        ZStack {
            Map(position: $position, selection: $selectedResult) {
                
                // 내가 찜한 장소 어노테이션
                
                
                // 관광지 어노테이션
                ForEach(touristResult, id: \.self) {  tour in
                    Annotation(tour.title, coordinate: CLLocationCoordinate2D(latitude: tour.latitude, longitude: tour.longitude)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.background)
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(.secondary, lineWidth: 1)
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
                            // 선택된 어노테이션의 위치로 MapCamera 조절
                            updatePosition(latitude: tour.latitude, longitude: tour.longitude, latitudeDelta: 0.06, longitudeDelta: 0.06)
                            
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
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(.secondary, lineWidth: 1)
                            Image(systemName: "fork.knife.circle")
                                .padding(5)
                                .frame(width: 16, height: 16)
                        }
                        .onTapGesture { // 마커 클릭시 이벤트
                            // 선택된 어노테이션의 위치로 MapCamera 조절
                            updatePosition(latitude: Double(restaurant.lat), longitude: Double(restaurant.lng), latitudeDelta: 0.06, longitudeDelta: 0.06)
                            
                            selectedImages = restaurant.images // 이미지 상태 업데이트
                            selectedTitle = restaurant.사업장명
                            selectedFoodCategory = restaurant.foodCategory
                            
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
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(.secondary, lineWidth: 1)
                            Image(systemName: "toilet")
                                .padding(5)
                                .frame(width: 16, height: 16)
                        }
                        .onTapGesture { // 마커 클릭시 이벤트
                            // 선택된 어노테이션의 위치로 MapCamera 조절
                            updatePosition(latitude: Double(toilet.WGS84위도), longitude: Double(toilet.WGS84경도), latitudeDelta: 0.06, longitudeDelta: 0.06)
                            
                            selectedTitle = toilet.화장실명
                            selectedToiletAddress = toilet.소재지도로명주소
                            selectedToiletCount1 = toilet.남성용_장애인용대변기수
                            selectedToiletCount2 = toilet.남성용_장애인용소변기수
                            selectedToiletCount3 = toilet.여성용_장애인용대변기수
                            selectedToiletTime = toilet.개방시간상세
                            selectedToiletIsBell = toilet.비상벨설치여부
                            selectedToiletBellSpot = toilet.비상벨설치장소
                            selectedToiletIsBaby = toilet.기저귀교환대유무
                            selectedToiletBabySpot = toilet.기저귀교환대장소
                            
                            showSheet.toggle() // Sheet 표시를 위한 상태 변경
                        }
                        .sheet(isPresented: $showSheet) {
                            ToiletSheet(title: $selectedTitle, address: $selectedToiletAddress, toiletCount1: $selectedToiletCount1, toiletCount2: $selectedToiletCount2, toiletCount3: $selectedToiletCount3, time: $selectedToiletTime, isBell: $selectedToiletIsBell, bellSpot: $selectedToiletBellSpot, isBaby: $selectedToiletIsBaby, babySpot: $selectedToiletBabySpot)
                                .presentationDetents([.height(300)]) // medium 또는 large 크기로 조절 가능
                                .presentationDragIndicator(.visible) // 사용자가 드래그 가능함을 나타내는 인디케이터 보이기
                        }
                        
                    }
                }
            }
            
            .mapControls() { // AppleMap 기본 버튼 생성
                MapControllView()
                    
            }
            .padding(EdgeInsets(top: 45, leading: 0, bottom: 0, trailing: 0))
            
            
            // 맵 위에 서치바, 카테고리 버튼들이 있는 VStack
            VStack (alignment: .leading) {
                MapSearchBarView(searchText: $searchText, isTextFieldFocused: _isTextFieldFocused, restaurantResult: $restaurantResult, touristResult: $touristResult, toiletResult: $toiletResult)
                    .padding(EdgeInsets(top: 50, leading: 15, bottom: 0, trailing: 0))
                    .onTapGesture {
                        isTextFieldFocused = true
                    }
                
                
                // 나중에 struct로 따로 분리할 필요가 있음
                // 음식점 버튼
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button(action: {
                            toiletResult = []
                            touristResult = []
                            restaurantResult = []
                            updatePosition() // 카메라 초기화
                            
                            if let results = data.searchRestaurants(searchText: "연돈") {
                                restaurantResult.append(contentsOf: results)  // 배열에 다른 배열의 내용을 추가
                            }
                        }) {
                            HStack(spacing: 5) {
                                Image(systemName: "fork.knife")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(Color.orange)
                                Text("음식점")
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color.black)
                            }
                            .frame(alignment: .center)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .padding(5)
                        
                        
                        // 반려동물 버튼
                        Button(action: {
                            toiletResult = []
                            touristResult = []
                            restaurantResult = []
                            updatePosition() // 카메라 초기화
                            
                            if let results = data.searchAnimalData() {
                                touristResult.append(contentsOf: results)
                            }
                        }) {
                            HStack(spacing: 5) {
                                Image(systemName: "dog")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(Color.brown)
                                Text("반려동물")
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color.black)
                            }
                            .frame(alignment: .center)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .padding(5)
                        
                        
                        // 화장실 버튼
                        Button(action: {
                            toiletResult = []
                            touristResult = []
                            restaurantResult = []
                            updatePosition() // 카메라 초기화
                            
                            if let results = data.searchToilets() {
                                toiletResult.append(contentsOf: results)  // 배열에 다른 배열의 내용을 추가
                            }
                        }) {
                            HStack(spacing: 5) { // 내부 요소 간 간격 조정
                                Image(systemName: "figure.dress.line.vertical.figure")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                Text("화장실")
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color.black)
                            }
                            .frame(alignment: .center)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .padding(5)
                        
                    }
                    .padding(.leading, 15)
                    
                }
                
                Spacer()
            }
        }
        .onTapGesture {
            isTextFieldFocused = false
        }
        
    }
    // --- Functions ---
    
    // 카메라 포지션을 업데이트 해주기 (아무것도 인자로 받지 않으면 초기화됨)
    func updatePosition(latitude: Double? = 33.361722862714, longitude: Double? = 126.53366495424248, latitudeDelta: Double? = 0.6, longitudeDelta: Double? = 0.6) {
        let newRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude ?? 33.361722862714,
                                           longitude: longitude ?? 126.53366495424248),
            span: MKCoordinateSpan(latitudeDelta: latitudeDelta ?? 0.6,
                                   longitudeDelta: longitudeDelta ?? 0.6)
        )
        position = .region(newRegion)
    }
    
    
} // End

//#Preview {
//    MapView()
//}
//
