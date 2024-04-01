//
//  PlanModel.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/28/24.
//

import Foundation

struct PlanGroup : Identifiable{
    var id : Int                    // 식별자
    var groupId : Int                   // index번호
    var groupTitle : String             // 여행 제목
    var groupFriend : String?           // 여행 동반자 ( 수기 입력 )
    var groupColor : Int                // 숫자에 따라 정해질 해당여행만의 색깔
    var groupCompleteStatus : Int      // 여행을 완료 했는지 구분
    var groupStartDate : String           // 여행 시작일자
    var groupEndDate : String            // 여행 끝날일자
    
    init(id: Int, groupId: Int, groupTitle: String, groupFriend: String? = nil, groupColor: Int, groupCompleteStatus: Int, groupStartDate: String, groupEndDate: String) {
        self.id = id
        self.groupId = groupId
        self.groupTitle = groupTitle
        self.groupFriend = groupFriend
        self.groupColor = groupColor
        self.groupCompleteStatus = groupCompleteStatus
        self.groupStartDate = groupStartDate
        self.groupEndDate = groupEndDate
    }
    
    
}

struct PlanDetail : Identifiable{
    var id : Int
    var planId : Int
    var pgId : Int
    var planTitle : String
    var planMemo : String?
    var planRating : Int?
    
    init(id: Int, planId: Int, pgId: Int, planTitle: String, planMemo: String? = nil, planRating: Int? = nil) {
        self.id = id
        self.planId = planId
        self.pgId = pgId
        self.planTitle = planTitle
        self.planMemo = planMemo
        self.planRating = planRating
    }
}

//ID값 부여
extension PlanGroup : Hashable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(groupId)
    }
}

extension PlanDetail : Hashable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(planId)
    }
}
