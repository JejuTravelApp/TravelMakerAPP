//
//  PlanCard.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/29/24.
//  planView에서 갖다 쓸 카드 디자인

import SwiftUI

struct PlanCard: View {
    
    //FIELD
    @State var planGroups : [PlanGroup] = []
    @State var isComplete : Bool = false
    @State var isCompleteUse : Int = 0 //체크박스 변수 0 은 미완료, 1은 완료.
    // 임의의 PlanGroup 데이터 생성
    let samplePlanGroups: [PlanGroup] = [
        PlanGroup(id: 1, groupId: 1, groupTitle: "여행 제목 1", groupColor: 1, groupCompleteStatus: 0, groupStartDate: "2024-03-29", groupEndDate: "2024-04-05"),
        PlanGroup(id: 2, groupId: 2, groupTitle: "여행 제목 2", groupColor: 2, groupCompleteStatus: 1, groupStartDate: "2024-04-10", groupEndDate: "2024-04-15"),
        PlanGroup(id: 3, groupId: 3, groupTitle: "여행 제목 3", groupColor: 3, groupCompleteStatus: 0, groupStartDate: "2024-04-10", groupEndDate: "2024-04-15"),
        PlanGroup(id: 4, groupId: 4, groupTitle: "여행 제목 4", groupColor: 4, groupCompleteStatus: 1, groupStartDate: "2024-04-10", groupEndDate: "2024-04-15"),
        PlanGroup(id: 5, groupId: 5, groupTitle: "여행 제목 5", groupColor: 5, groupCompleteStatus: 0, groupStartDate: "2024-04-10", groupEndDate: "2024-04-15"),
        PlanGroup(id: 6, groupId: 6, groupTitle: "여행 제목 6", groupColor: 6, groupCompleteStatus: 1, groupStartDate: "2024-04-10", groupEndDate: "2024-04-15"),
        PlanGroup(id: 7, groupId: 7, groupTitle: "여행 제목 7", groupColor: 7, groupCompleteStatus: 0, groupStartDate: "2024-04-10", groupEndDate: "2024-04-15"),
        
    ]
    
    
    //BODY 스크롤 뷰로 만들어야 함
    var body: some View {
        NavigationStack {
            List {
                ForEach(samplePlanGroups) { pGroup in
                    NavigationLink(destination: PlanDetailView(planGroup_text: pGroup.groupTitle)) {
                        cardView(plangroup: pGroup)
                            .frame(height: 60)
                    }
                }
            }
            .navigationTitle("Plan")
        }
        //FUNCTION
    }
    
    
    
}
//EXTENSION
extension PlanCard{
    //card View
    private func cardView(plangroup : PlanGroup) -> some View{
//        NavigationStack{
//            VStack{
//                List(planGroups, id: \.id){ plangroup in
//                    VStack{
//                        HStack(spacing: 20){
//                            Toggle(isOn: $isComplete.self){
//                                Text("PLANGROUP TITLE")
//                                    .strikethrough(plangroup.groupCompleteStatus != 0)
//                                    .bold()
//                                    .animation(.default)
//                            }
//                        }
//                        Spacer()
//                        Text("StartDate~EndDate")
//                    }
//                }
//            }
//        }
//        .navigationTitle("Plan")
//   
        NavigationStack{
            VStack{
                HStack(spacing: 20){
                    Toggle(isOn: .constant(plangroup.groupCompleteStatus == 1)){
                        Text(plangroup.groupTitle)
                            .strikethrough(plangroup.groupCompleteStatus != 0)
                            .bold()
                            .animation(.default)
                    }
                }
                Spacer()
                
                Text("\(plangroup.groupStartDate) ~ \(plangroup.groupEndDate)")
            }
        }
        .navigationTitle("Plan")
    }
    
    //card image (systemImage)
    
    
    
    
}

