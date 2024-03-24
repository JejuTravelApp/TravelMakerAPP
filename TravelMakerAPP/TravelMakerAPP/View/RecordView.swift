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
            let record1 = RecordModel(title: "애월 여행기 1", imageList: imageList1)
            
            let imageList2 = ["airtag.fill", "macpro.gen3.fill", "sun.dust.fill"]
            let record2 = RecordModel(title: "애월 여행기 2", imageList: imageList2)
            
            // recordList에 RecordModel 인스턴스 추가
            recordList.append(contentsOf: [record1, record2])
        })

    }
}

