//
//  RecordView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//  Description: 다녀온 여행의 기록을 관리하는 뷰

import SwiftUI

struct RecordView: View {
    
    @State var recordList = [RecordModel]() // RecordModel생성자
    @State var scrollIndelx: Int = 0 // index번호로 나중에 DB의 ID를 사용
    
    var body: some View {
        NavigationView { // 이걸로 감싸줘야 해당 화면을 넘기고 title을 줄 수 있음
            VStack {
                ScrollViewReader { proxy in // Record를 클릭했을 때 Scroll을 클릭한 Record로 가게하기 위한 ScrollViewReader
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(recordList, id: \.self) { record in
                            RecordImageView(record: record, scrollIndex: $scrollIndelx)
                                .id(record.rId)
                        }
                        //                    .shadow(radius: 5, x: 5, y: 5)
                        .onChange(of: scrollIndelx) { // @Binding으로 묶여있는 scrollIndelx를 통해서 구현, Search의 개념이라고 생각하면 됨
                            withAnimation {
                                proxy.scrollTo(scrollIndelx, anchor: .center) // 여기서 이동
                            }
                        }
                    }
                    
                }
            }
            .navigationBarTitle("여행기록", displayMode: .inline) // VStack에 BarTitle이 붙음
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: RecordAddView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear(perform: {
                recordList.removeAll()
                // 예시 데이터
                let imageList1 = ["arcade.stick.console", "playstation.logo", "bolt.car.fill"]
                let record1 = RecordModel(rId: 1, title: "황도와 가족들의 애월 여행기", imageList: imageList1, rTag: "우정여행, 반려견동반", rStartDate: "2023.12.01", rEndDate: "2023.12.05", rFriend: "가족들, 정황도, 호식이", rReivew: "날이 추웠지만 좋았음")
                
                let imageList2 = ["airtag.fill", "macpro.gen3.fill", "sun.dust.fill"]
                let record2 = RecordModel(rId: 2, title: "홀로 애월 여행기", imageList: imageList2, rTag: "홀로여행", rStartDate: "2024.02.13", rEndDate: "2024.02.16", rFriend: "홀로여행", rReivew: "전보단 따듯해졌지만 여전히 추웠음")
                
                let imageList3 = ["airtag.fill", "macpro.gen3.fill", "sun.dust.fill"]
                let record3 = RecordModel(rId: 5, title: "친구들과 제주 여행기", imageList: imageList3, rTag: "우정여행, 무계획, P들의 모임", rStartDate: "2024.03.02", rEndDate: "2024.03.05", rFriend: "맹구, 땡칠이, 홍길동", rReivew: "친구들과 간만에 모여서 좋았음\n다들 무계획이라서 갑자기 간 여행이지만 재밌었음")
                
                
                
                // recordList에 RecordModel 인스턴스 추가
                recordList.append(contentsOf: [record1, record2, record3])
            })
            
        }
    }
}

