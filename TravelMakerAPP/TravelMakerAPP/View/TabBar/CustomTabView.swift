//
//  CustomTabView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//  Description: 탭바를 커스텀하기위해 만든 커스텀 탭뷰

import SwiftUI

// enum은 class처럼 쓸 수 있지만 enum에 선언된 것 외에 다른것은 쓰지 못한다는점에서 안전성이 있다고 알려져있음
enum Tab {
    case house
    case calendar
    case map
    case airplane
}

struct CustomTabView: View {
    
    @Binding var selectedTab: Tab
    
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
                    }
                }
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
                    }
                }
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
                    }
                }
            }
            .frame(width: tabWidth) // 너비 설정
            
            Spacer()
            
            // 레코드 탭
            Button {
                selectedTab = .airplane
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: "airplane")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(selectedTab == .airplane ? Color.red : Color.gray)
                    
                    if selectedTab == .airplane {
                        Text("여행 기록")
                            .foregroundColor(Color.red)
                    }
                }
            }
            .frame(width: tabWidth) // 너비 설정
            
            Spacer()
        }
        .frame(height: 65) // 전체 탭 뷰의 높이 설정
    }
}
