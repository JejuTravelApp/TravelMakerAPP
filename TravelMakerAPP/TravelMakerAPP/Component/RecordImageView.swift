//
//  RecordImageView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/24/24.
//

import SwiftUI

struct RecordImageView: View {
    
    var record: RecordModel
    @State var toggleStatus = false
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(record.title)
                    .font(.system(size: 22))
                    .bold()
                    .padding(8)
                
                Text("\(record.rStartDate)~\(record.rEndDate)")
                    .font(.system(size: 12))
                    .padding(.vertical, 8)
                
            }
            Text("이 여행친구: \(record.rFriend)")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(record.imageList, id: \.self) { imageName in
                        Image(systemName: imageName)
                            .resizable()
                            .frame(width: 260, height: 230)
                        //                                .border(Color.black, width: 1)
                            .background(Color.black)
                            .cornerRadius(5)
                    }
                }
            }
            .frame(height: 240) // ScrollView의 높이 설정
            .background(.thinMaterial)
            
            if toggleStatus {
                Text("")
                Text(record.rReivew)
                    .background(Color.gray)
                    .cornerRadius(5)
            }
        }
        .border(Color.black)
        .onTapGesture {
            toggleStatus.toggle()
//            if record.id {
//                
//            }
        }
        
        .padding()
        
    }
}
