//
//  MapSheetView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/15/24.
//

import SwiftUI

struct MapSheetView: View {
    
    
    @Binding var title: String // 매장명
    @Binding var images: String // 이미지
    @State var selectedImage: Int = 0 // 이미지 index
    
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 20))
                .bold()
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
            
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) { 
                    HStack(alignment: .center) {
                        //                                      extractImageUrls(from: images).count == 1 ? .center : .firstTextBaseline
                        ForEach(0..<extractImageUrls(from: images).count, id: \.self) { index in
                            let url = extractImageUrls(from: images)[index]
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(width: 250, height: 200)
                                    // 이미지 한장일 때 가운데정렬
                                        .padding(.leading, extractImageUrls(from: images).count == 1 ? (geometry.size.width - 250) / 2 : 0)
                                    
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
            }
        }
    }
    // --- Functions ---
    // 이미지 받아온 String값을 뽑아서 URL로 목록을 추출하는 함수 연돈
    func extractImageUrls(from imagesString: String) -> [URL] {
        // 정규 표현식을 사용해서 URL을 찾기
        let pattern = "(https?:\\/\\/.*?)(\"|\\s|$)"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        
        let nsString = imagesString as NSString
        let results = regex.matches(in: imagesString,
                                    range: NSRange(location: 0, length: nsString.length))
        
        // 추출된 URL 문자열을 실제 URL 배열로 변환
        return results.compactMap { result in
            let urlString = nsString.substring(with: result.range(at: 1))
            return URL(string: urlString)
        }
    }
}
