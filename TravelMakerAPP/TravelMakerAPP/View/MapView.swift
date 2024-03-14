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
    @State var searchResult: [RestaurantDataModel] = [] // RestaurantDataModel타입의 검색 결과 형식
    
    // @@ === View Field === @@
    @State private var searchText: String = "" // 검색 텍스트필드
    @State private var showSheet: Bool = false // sheet status
    @State private var selectedTitle: String = "" // 마커에 선택된 매장이름을 담을 변수
    @State private var selectedImages: String = "" // 마커에서 선택된 이미지를 담을 변수
    
    // @@ === Constructor === @@
    var data = MapDataLoad() // json데이터 불러오기 및 검색기능이 있는 class 생성자 연돈
    
    
    var body: some View {
        ZStack {
            Map(position: $position, selection: $selectedResult) {
                ForEach(searchResult, id: \.self) {  restrent in
                    Annotation(restrent.사업장명, coordinate: CLLocationCoordinate2D(latitude: Double(restrent.lat) ?? 37.5665, longitude: Double(restrent.lng) ?? 126.9780)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.background)
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.secondary, lineWidth: 5)
                            Image(systemName: "fork.knife.circle")
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
                MapSearchBarView(searchText: $searchText, searchResult: $searchResult)
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 30))
                
                // 나중에 struct로 따로 분리할 필요가 있음
                HStack {
                    Button(action: {
                        if let results = data.searchRestaurants(searchText: "연돈") {
                            searchResult.append(contentsOf: results)  // 배열에 다른 배열의 내용을 추가
                        }
                    }) {
                        Image(systemName: "fork.knife")
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
}
//#Preview {
//    MapView()
//}
