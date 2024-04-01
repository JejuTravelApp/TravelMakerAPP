//
//  PlanView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//  Description: 내 여행 플랜을 관리하는 뷰

import SwiftUI

struct PlanView: View {

//FIELD START =====================================
//    @Binding var plan : [Plan] = [] //plan이 있을 경우 데이터를 담을 곳.
    @State private var currentDate = Date()
    @State private var clickedDate : Date?
    
    //toolbarItem을 눌렀을 때 sheet이 뜨게 할 상태변수
    @State private var isAddSheet : Bool = false
    
    
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
        GeometryReader{ geometry in
            //width : 390
            //height : 701
            
            VStack{
//                alwaysDate
//                    .font(.title3.bold())
//                    .position(x:geometry.size.width/2)
                calendarView
//                    .background(.opacity(0.3))
//                    .position(x:geometry.size.width/2)
                    .padding(0)
                
                Divider()
                
                ScrollView{
                    addPlanButton
                        .background(.red.opacity(0.1))
                    Spacer(minLength: 5)
                    PlanCard()
                                        
                }
                
      

                
                
            }
        }
    }
}//BDOY END =========================================
//EXTENSION START ===================================
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
            ZStack{
                Image("jejuWinterAI")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.5)
                DatePicker(
                    "Start Date",
                    selection: $currentDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
//                .frame(height: 350)
            }
        }
    }
    
    //여행일정 추가 버튼 (일정이 없을 때)
    private var addPlanButton : some View{
        VStack{
            //일정이 있으면 일정 보여주고 일정이 없으면 일정추가 버튼 보여주기
            Button("", systemImage: "calendar.badge.plus"){
                self.isAddSheet.toggle()
            }
//            .buttonBorderShape(.capsule)
            .frame(maxWidth: .infinity)
            .font(.system(size: 40))
            
            
            Text("여행일정을 추가해 주세요")
        }
        .sheet(isPresented: $isAddSheet){
            PlanInsertSheet()
        }
        .frame(height: 100)
    }
    
    //여행일정 보여줄 뷰 (일정이 있을 때) - List
    private var addedPlanView : some View{
        VStack{
            NavigationStack{
                
            }
        }
    }
}

//EXTENSION END =========================================
