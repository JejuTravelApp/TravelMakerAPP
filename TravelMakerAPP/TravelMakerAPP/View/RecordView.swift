//
//  RecordView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//  Description: 다녀온 여행의 기록을 관리하는 뷰

import SwiftUI

struct RecordView: View {
    
    @State var recordList = [RecordModel]() // RecordModel생성자
    
    var body: some View {
        VStack() {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(recordList, id: \.self) { record in
                    RecordImageView(record: record)
                }
            }
        }
        .onAppear(perform: {
            // 예시 데이터
            let imageList1 = ["arcade.stick.console", "playstation.logo", "bolt.car.fill"]
            let record1 = RecordModel(title: "황도와 애월 여행기", imageList: imageList1, rTag: "#우정여행, #반려견동반", rStartDate: "2023.12.01", rEndDate: "2023.12.05", rFriend: "정황도", rReivew: "날이 추웠지만 좋았음")
            
            let imageList2 = ["airtag.fill", "macpro.gen3.fill", "sun.dust.fill"]
            let record2 = RecordModel(title: "홀로 애월 여행기", imageList: imageList1, rTag: "#홀로여행", rStartDate: "2024.02.13", rEndDate: "2024.02.16", rFriend: "홀로여행", rReivew: "전보단 따듯해졌지만 여전히 추웠음")

            
            // recordList에 RecordModel 인스턴스 추가
            recordList.append(contentsOf: [record1, record2])
        })

    }
}

