//
//  ContentView.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/7/24.
//  Description: 앱의 탭바를 관리하는 뷰

import SwiftUI

struct TabBarView: View {
        
    @State var selectedTab: Tab = .house
    @State var searchText: String = ""
    @State var currentDate = Date()
    
    var body: some View {
        
        VStack {
            Spacer()
            switch selectedTab {
            case .house:
                AISearchTest(searchText: searchText, currentDate: currentDate)
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
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

#Preview {
    TabBarView()
}
