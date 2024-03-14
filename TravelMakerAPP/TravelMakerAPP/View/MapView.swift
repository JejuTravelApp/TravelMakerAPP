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
    
    // @@ === Map === @@
    // 맵의 초기 띄워줄 위도, 경도, 줌을 설정하는 position으로 제주도 가운데인 한라산 봉우리를 기본값으로 찍어놓음
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.361722862714, longitude: 126.53366495424248),
        span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.6)
    ))
    @State private var selectedResult: MKMapItem? // 선택된 마커를 알고있을 변수

    
    
    
    var body: some View {
        ZStack {
            Map(position: $position, selection: $selectedResult) {
                
            }
            
        }
    }
}
//#Preview {
//    MapView()
//}
