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
    @State var restaurantResult: [RestaurantDataModel] = [] // RestaurantDataModel타입의 검색 결과 형식
    @State var toiletResult: [ToiletDataModel] = []
    
    // @@ === View Field === @@
    @State private var searchText: String = "" // 검색 텍스트필드
    @State private var showSheet: Bool = false // sheet status
    @State private var selectedTitle: String = "" // 마커에 선택된 매장이름을 담을 변수
    @State private var selectedImages: String = "" // 마커에서 선택된 이미지를 담을 변수
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = 0
    
    // @@ === Constructor === @@
    var data = MapDataLoad() // json데이터 불러오기 및 검색기능이 있는 class 생성자 연돈
    
    
    var body: some View {
        ZStack {
            Map(position: $position, selection: $selectedResult) {
                ForEach(restaurantResult, id: \.self) {  restrent in
                    Annotation(restrent.사업장명, coordinate: CLLocationCoordinate2D(latitude: Double(restrent.lat) ?? 37.5665, longitude: Double(restrent.lng) ?? 126.9780)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.background)
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(.secondary, lineWidth: 2)
                            Image(systemName: "fork.knife.circle")
                                .padding(5)
                                .frame(width: 20, height: 20)
                        }
                        .onTapGesture { // 마커 클릭시 이벤트
                            selectedImages = restrent.images // 이미지 상태 업데이트
                            selectedTitle = restrent.사업장명
                            //                            print(selectedImages)
                            showSheet.toggle() // Sheet 표시를 위한 상태 변경
                        }
                        .sheet(isPresented: $showSheet) {
                            MapSheetView(title: $selectedTitle, images: $selectedImages) // 선택된 이미지 전달
                                .presentationDetents([.height(300), .large]) // medium 또는 large 크기로 조절 가능
                                .presentationDragIndicator(.visible) // 사용자가 드래그 가능함을 나타내는 인디케이터 보이기
                        }
                    }
                    
                }
                
                ForEach(toiletResult, id: \.self) {  toilet in
                    Annotation(toilet.화장실명, coordinate: CLLocationCoordinate2D(latitude: Double(toilet.WGS84위도) ?? 37.5665, longitude: Double(toilet.WGS84경도) ?? 126.9780)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.background)
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(.secondary, lineWidth: 2)
                            Image(systemName: "toilet")
                                .padding(5)
                                .frame(width: 20, height: 20)
                        }
                    }
                }


            }
            .mapControls() { // AppleMap 기본 버튼 생성
                MapControllView()
            }


            // 맵 위에 서치바, 카테고리 버튼들이 있는 VStack
            VStack (alignment: .leading) {
                MapSearchBarView(searchText: $searchText, searchResult: $restaurantResult)
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 30))
                
                // 나중에 struct로 따로 분리할 필요가 있음
                HStack {
                    
//                    searchCategoryButton(searchResult: [RestaurantDataModel], searchText: "연돈", buttonImage: "fork.knife")
//                    searchCategoryButton(searchText: "애월", buttonImage: "figure.dress.line.vertical.figure")
                    
                    Button(action: {
                        toiletResult = []
//                        restaurantResult = []
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
                        restaurantResult = []
//                        toiletResult = []
                        if let results = data.searchToilets(searchText: "애월") {
                            toiletResult.append(contentsOf: results)  // 배열에 다른 배열의 내용을 추가
                        }
                    }) {
                        Image(systemName: "figure.dress.line.vertical.figure")
                    }
                    .frame(width: 38, height: 30)
                    .background(.white)
                    .cornerRadius(10) // 테두리 둥글게
                    .padding(10)

                }
                
                Spacer()
            }

            
        }
    }
    // --- Functions ---
}
//struct searchCategoryButton: View {
//    
//    @Binding var searchResult: [RestaurantDataModel] // RestaurantDataModel타입의 검색 결과 형식
//    @Binding var searchText: String
//    @Binding var buttonImage: String
//    var data = MapDataLoad() // json데이터 불러오기 및 검색기능이 있는 class 생성자 연돈
//    
//    var body: some View {
//        Button(action: {
//            if let results = data.searchRestaurants(searchText: searchText) {
//                searchResult.append(contentsOf: results)  // 배열에 다른 배열의 내용을 추가
//            }
//        }) {
//            Image(systemName: buttonImage)
//        }
//        .frame(width: 38, height: 30)
//        .background(.white)
//        .cornerRadius(10) // 테두리 둥글게
//        .padding(10)
//    }
//}
//
//
//struct mapAnnotations: View {
//    
//    
//    
//    var body: some View {
//        ForEach(restaurantResult, id: \.self) {  restrent in
//            Annotation(restrent.사업장명, coordinate: CLLocationCoordinate2D(latitude: Double(restrent.lat) ?? 37.5665, longitude: Double(restrent.lng) ?? 126.9780)) {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 5)
//                        .fill(.background)
//                    RoundedRectangle(cornerRadius: 5)
//                        .stroke(.secondary, lineWidth: 5)
//                    Image(systemName: "fork.knife.circle")
//                        .padding(5)
//                        .frame(width: 20, height: 20)
//                }
//            }
//        }
//
//    }
//}



//#Preview {
//    MapView()
//}
