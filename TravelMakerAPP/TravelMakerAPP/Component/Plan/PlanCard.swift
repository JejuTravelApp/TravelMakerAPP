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
    
    
    //BODY 스크롤 뷰로 만들어야 함
    var body: some View {
            VStack{
                List{
                    ForEach(planGroups, id: \.id){pGroup in
                        NavigationLink(destination: PlanDetailView()){
                            VStack(alignment: .leading){
                                //카드에 적힐 내용
                                cardView
                            }
                        }
                    }
                }
            }
    }
    
    //FUNCTION
}

//EXTENSION
extension PlanCard{
    //card View
    private var cardView : some View{
        NavigationStack{
            List(planGroups, id: \.id){ plangroup in
                VStack{
                    HStack(spacing: 20){
                        Toggle(isOn: $isComplete.self){
                            Text(plangroup.groupTitle)
                                .strikethrough(plangroup.groupCompleteStatus != 0)
                                .bold()
                                .animation(.default)
                        }
                    }
                    Spacer()
                    Text("\(plangroup.groupStartDate)~\(plangroup.groupEndDate)")
                }
            }
        }
        .navigationTitle("Plan")
        
    }
    
    //card image (systemImage)
    
    
    
    
}

