//
//  ContentView.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/7/24.
//  Description: 앱의 탭바를 관리하는 뷰

import SwiftUI

struct TabBarView: View {
        
    @State var selectedTab: Tab = .house
    
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
            case .photo:
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

//    @State var selection = 0 // tab index
//    @State var isAnimating: Bool = false


//        TabView(selection: $selection){
//            HomeView()
//                .tabItem {
//                    Image(systemName: "house")
//                    if selection == 0 {
//                            Text("홈")
//                                .offset(y: isAnimating ? 10 : UIScreen.main.bounds.size.height
//                                ) // UIScreen.main.bounds.size.width: 해당 디바이스의 너비값
//                            .animation(.easeIn(duration: 1), value: isAnimating)
//                    }
//                }
//                .tag(0)
//
//            PlanView()
//                .tabItem {
//                    Image(systemName: "calendar")
//                    if selection == 1 {
//                        Text("여행 계획")
//                    }
//                }
//                .tag(1)
//
//            MapView(isAnimating: $isAnimating)
//                .tabItem {
//                    Image(systemName: "map")
//                    if selection == 2 {
//                        Text("제주 지도")
//                    }
//                }
//                .tag(2)
//            RecordView()
//                .tabItem {
//                    Image(systemName: "figure.2")
//                    if selection == 3 {
//                        Text("여행 기록")
//                    }
//                }
//                .tag(3)
//
//
//
//
//        }
//        .accentColor(.red)
//        .frame(height: 200)
//        .onAppear(perform: {
//            isAnimating.toggle()
//        })
