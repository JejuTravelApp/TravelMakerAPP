//
//  CustomTabView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//  Description: 탭바를 커스텀하기위해 만든 커스텀 탭뷰

import SwiftUI

enum Tab {
    case house
    case calendar
    case map
    case photo
}

struct CustomTabView: View {
    
    @Binding var selectedTab: Tab
    @State var isHouseAnimating: Bool = true
    @State var isCalendarAnimating: Bool = true
    @State var isMapAnimating: Bool = true
    @State var isPhotoAnimating: Bool = true
    
    // 탭의 너비를 계산하기 위해 사용할 수 있는 기본값
    let tabWidth: CGFloat = UIScreen.main.bounds.width / 5
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) { // 간격을 명시적으로 제어하기 위해 spacing 값을 조정
            Spacer()
            
            // 홈 탭
            Button {
                selectedTab = .house
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: "house")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(selectedTab == .house ? Color.red : Color.gray)
                    
                    if selectedTab == .house {
                        Text("홈")
                            .foregroundColor(Color.red)
                            .offset(y: isHouseAnimating ? 0 : 100) // UIScreen.main.bounds.size.width: 해당 디바이스의 너비값
                            .animation(.easeIn(duration: 1), value: isHouseAnimating)
                    }
                }
                .offset(x: -5)
            }
            .frame(width: tabWidth) // 각 버튼의 너비 설정
            
            Spacer()
            
            // 플랜 탭
            Button {
                selectedTab = .calendar
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(selectedTab == .calendar ? Color.red : Color.gray)
                    
                    if selectedTab == .calendar {
                        Text("여행 계획")
                            .foregroundColor(Color.red)
                            .offset(y: isCalendarAnimating ? 0 : 100) // UIScreen.main.bounds.size.width: 해당 디바이스의 너비값
                            .animation(.easeIn(duration: 1), value: isCalendarAnimating)
                    }
                }
                .offset(x: -5)
            }
            .frame(width: tabWidth) // 너비 설정
            
            Spacer()
            
            // 지도 탭
            Button {
                selectedTab = .map
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(selectedTab == .map ? Color.red : Color.gray)
                    
                    if selectedTab == .map {
                        Text("제주 지도")
                            .foregroundColor(Color.red)
                            .offset(y: isMapAnimating ? 0 : 100) // UIScreen.main.bounds.size.width: 해당 디바이스의 너비값
                            .animation(.easeIn(duration: 1), value: isMapAnimating)
                    }
                }
                .offset(x: -5)
            }
            .frame(width: tabWidth) // 너비 설정
            
            Spacer()
            
            // 레코드 탭
            Button {
                selectedTab = .photo
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(selectedTab == .photo ? Color.red : Color.gray)
                    
                    if selectedTab == .photo {
                        Text("여행 기록")
                            .foregroundColor(Color.red)
                            .offset(y: isPhotoAnimating ? 0 : 100) // UIScreen.main.bounds.size.width: 해당 디바이스의 너비값
                            .animation(.easeIn(duration: 1), value: isPhotoAnimating)
                    }
                }
                .offset(x: -5)
            }
            .frame(width: tabWidth) // 너비 설정
            
            Spacer()
        }
        .frame(height: 85) // 전체 탭 뷰의 높이 설정
    }
}

//#Preview {
//    CustomTabView()
//}
