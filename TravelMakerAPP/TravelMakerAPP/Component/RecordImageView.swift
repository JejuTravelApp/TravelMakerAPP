//
//  RecordImageView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/24/24.
//

import SwiftUI

struct RecordImageView: View {
    
    var record: RecordModel
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(record.title)
                .bold()
                .padding(5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top) {
                        ForEach(record.imageList, id: \.self) { imageName in
                            Image(systemName: imageName)
                                .resizable()
                                .frame(width: 200, height: 200)
                                .border(Color.black, width: 1)
                        }
                    }
                }
                .frame(height: 200) // ScrollView의 높이 설정
                .background(.thinMaterial)
            }
        
    }
}
