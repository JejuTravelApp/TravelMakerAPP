//
//  TourSheet.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/17/24.
//  Description: 여행지 Annotation 클릭시 나오는 sheet

import SwiftUI
import UniformTypeIdentifiers // 텍스트 복사를 위해

struct TourSheet: View {
    
    @Binding var title: String
    @Binding var category: String
    @Binding var address: String
    @Binding var images: String
    @Binding var intro: String
    @Binding var phone: String
    @Binding var tag: String
    
    @State private var isCopied: Bool = false // 복사될때 알림을 띄우기용
    
    var imageLoad = ImageLoad()
    
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text(title)
                            .font(.system(size: 25))
                            .bold()
                            .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 10))
                        Text(category)
                            .font(.system(size: 16))
                            .foregroundStyle(Color.gray)
                            .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
                        
                        Spacer()
                        
                        Button {
                            //
                        } label: {
                            VStack (spacing: 3) {
                                Image(systemName: "plus")
                                Text("Plan 추가")
                                    .font(.system(size: 12))
                            }
                        }
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 10))
                    }
                    .padding(.horizontal, 10)
                    
                    
                    HStack {
                        Text(address == "x" ? "주소정보 없음" : address)
                            .font(.system(size: 15))
                            .foregroundStyle(Color.gray)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 5))
                        
                        Button {
                            let pasteboard = UIPasteboard.general
                            pasteboard.string = address
                            if pasteboard.string != nil{
                                withAnimation {
                                    isCopied = true
                                }
                                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.5) {
                                    withAnimation {
                                        isCopied = false
                                    }
                                }
                            }
                        } label: {
                            // 버튼 레이블에 조건을 줄려면 Group을 사용해야함
                            Group {
                                if address != "x" {
                                    Image(systemName: "clipboard")
                                        .resizable()
                                        .frame(width: 10, height: 15)
                                        .foregroundColor(Color.gray)
                                } else {
                                    EmptyView()
                                }
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    
                    Divider()
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                    
                    // ImageScroll
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center) {
                            ForEach(0..<imageLoad.extractImageUrls(from: images).count, id: \.self) { index in
                                let url = imageLoad.extractImageUrls(from: images)[index]
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .frame(width: 260, height: 230)
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
                    .frame(height: 230) // ScrollView의 높이 설정
                    .background(.thinMaterial)
                    .padding(.horizontal, 10)
                    
                    // Tag
                    ScrollView (.horizontal, showsIndicators: false) {
                        // 태그 배열 생성
                        let tagArray = showTag(tags: tag)
                        HStack {
                            ForEach(tagArray, id: \.self) { tag in
                                Text("#\(tag)")
                                    .font(.system(size: 15))
                                    .bold()
                                    .padding(8)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(50)
                            }
                        }
                    }
                    
                    .padding(.horizontal, 10)
                    
                    Text("장소 정보")
                        .font(.system(size: 20))
                        .bold()
                        .padding(10)
                    
                    Divider()
                        .padding(.horizontal, 10)
                    
                    Text(intro)
                        .padding(6) // 텍스트 주변에 패딩을 추가
                        .background(.thinMaterial)
                        .cornerRadius(10) // 모서리를 둥글게
                    //                        .padding(10)
                        .frame(width: geometry.size.width, alignment: .center)
                    
                    
                }
                
            }
            
            
            if isCopied {
                VStack(alignment: .center) {
                    Spacer()
                    Text("클립보드에 복사되었습니다!")
                        .foregroundColor(.white)
                        .bold()
                        .font(.footnote)
                        .frame(width: 180, height: 35)
                        .background(Color.gray.cornerRadius(7))
                        .padding(.bottom, 10)
                }
            }
        }
        
    }
    // --- Functions ---
    // 문자열 분리 함수
    func showTag(tags: String) -> [String] {
        // 문자열을 쉼표로 분리
        let tagList = tags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        
        // 중복 제거
        let uniqueTags = Array(Set(tagList))
        
        return uniqueTags
    }
    
    
} // End


//#Preview {
//    TourSheet()
//}
