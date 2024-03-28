//
//  RecordAddView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/28/24.
//

import SwiftUI

struct RecordAddView: View {
    var body: some View {
        NavigationView { // 이걸로 감싸줘야 해당 화면을 넘기고 title을 줄 수 있음
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            

        }
        .navigationBarTitle("기록 생성", displayMode: .inline) // VStack에 BarTitle이 붙음
    }
}

//#Preview {
//    RecordAddView()
//}
