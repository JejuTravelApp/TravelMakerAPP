//
//  ContentView.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/7/24.
//  Description: 앱의 탭바를 관리하는 뷰

import SwiftUI

struct TabBarView: View {
        
    @State var selectedTab: Tab = .house // 기본값
    
    var body: some View {
        
        VStack {
            Spacer()
            switch selectedTab {
            case .house:
                HomeView()
            case .calendar:
                PlanView()
            case .map:
                MapView()
            case .airplane:
                RecordView()
            }
            Spacer()
            CustomTabView(selectedTab: $selectedTab)
                .padding(.bottom, 15)
        }
        .edgesIgnoringSafeArea([.bottom, .top]) // 이걸 지정해줘야 위, 아래 UI가 가리지 않게됨
        
    }
}

#Preview {
    TabBarView()
}
