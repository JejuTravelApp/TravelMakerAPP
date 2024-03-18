//
//  TourSheet.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/17/24.
//

import SwiftUI

struct TourSheet: View {
    
    @Binding var title: String
    @Binding var images: String
    
    var imageLoad = ImageLoad()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.system(size: 25))
                .bold()
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 10))
            
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center) {
                        ForEach(0..<imageLoad.extractImageUrls(from: images).count, id: \.self) { index in
                            let url = imageLoad.extractImageUrls(from: images)[index]
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(width: 250, height: 200)
                                    // 이미지 한장일 때 가운데정렬
                                        .padding(.leading, imageLoad.extractImageUrls(from: images).count == 1 ? (geometry.size.width - 250) / 2 : 0)
                                    
                                case .failure:
                                    Text("이미지를 로드할 수 없습니다. 😢")
                                        .frame(width: geometry.size.width)
                                case .empty:
                                    ProgressView()
                                        .frame(width: geometry.size.width)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        
                    }
                }
                .frame(height: 200) // ScrollView의 높이 설정
                .background(.thinMaterial)
                .padding(.horizontal, 10)
            }
        }
        
        
    }
}

//#Preview {
//    TourSheet()
//}
