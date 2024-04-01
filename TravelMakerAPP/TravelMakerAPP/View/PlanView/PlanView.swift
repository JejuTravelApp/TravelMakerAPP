//
//  PlanView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//  Description: 내 여행 플랜을 관리하는 뷰

import SwiftUI

struct PlanView: View {

//FIELD START =====================================
    @State private var currentDate = Date()
    @State private var clickedDate : Date?
    
    
    // 항상 보여줄 DateFormatter
    var alwaysDateFormatter : DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd EEE HH:mm"
        return formatter
    }
    // 선택한 날짜에 대한 DateFormatter
    var selectedDateFormatter : DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
    // plan에 적힌 것에 대한 DateFormatter
    var planDateFormatter : DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
    //달력 init
    init(
        currentDate : Date = Date(),
        clickedDate : Date? = nil
    ){
        _currentDate = State(initialValue: currentDate)
        _clickedDate = State(initialValue: clickedDate)
    }
    
//FIELD END  ========================================
//BODY START ========================================
    var body: some View {
        VStack{
            alwaysDate
            calendarView
            Spacer()
            addPlanButton
            
            
        }
    }
}//BDOY END =========================================

extension PlanView{
    //현재 시간을 보여주기. 이걸 어따쓰지? 필요없을 것 같기도 하다.
    private var alwaysDate : some View{
        HStack{
            Text("현재시간 : \(currentDate, formatter: alwaysDateFormatter)")
        }
    }
    
    //DatePicker를 달력형식으로 보여줄 변수
    private var calendarView : some View{
        HStack{
            DatePicker(
                "Start Date",
                selection: $currentDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .toolbar{
                ToolbarItem(placement: .navigation, content: ){
                    
                }
            }
        }
    }
    
    //여행일정 추가 버튼 (일정이 없을 때)
    private var addPlanButton : some View{
        VStack{
            //일정이 있으면 일정 보여주고 일정이 없으면 일정추가 버튼 보여주기
            Button("일정추가"){
                
            }
        }
    }
}

