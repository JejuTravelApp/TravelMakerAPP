//
//  MapControllView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//  Description: Apple맵의 기본적인 버튼을 구성하는 컴포넌트

import SwiftUI
import _MapKit_SwiftUI

struct MapControllView: View {
    @Namespace var mapScope
    
    var body: some View {
        Map(scope: mapScope) // .bottomLeading
            .overlay(alignment: .bottomLeading) {
                VStack {
                    MapUserLocationButton(scope: mapScope) // 내 위치로 가기 버튼
                    MapPitchToggle(scope: mapScope) // 3D 활성화 버튼
//                    MapScaleView(scope: mapScope) // 확대축소 거리
                    MapCompass(scope: mapScope) // 나침반
                        .mapControlVisibility(.visible)
                        
                }
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 15))
                .buttonBorderShape(.circle)
            }
            .mapScope(mapScope)
    }
}
