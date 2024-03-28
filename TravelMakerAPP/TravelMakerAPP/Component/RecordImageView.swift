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
    @FocusState var isFocused: Bool
    @Binding var scrollIndex: Int
    
    var body: some View {
        ZStack { // 전체 테두리
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .fill(Color.white) // <<<<<<<< 바꿔야함
                .padding(10)
                .shadow(radius: 5, x: 5)
        
        VStack (alignment: .leading) { // 테두리 안쪽
            // rTitle
            HStack {
                Text(record.title)
                    .font(.system(size: 20))
                    .bold()
                    .padding(8)
                    .focused($isFocused)
                Spacer()
                Text("\(record.rStartDate) ~ \(record.rEndDate)")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.gray)
                    .padding(8)
                
            }
            // rFriend
            HStack {
                Image(systemName: "figure.2")
                    .padding(.trailing, 3)
                    .bold()
                let friendArray = showTag(tags: record.rFriend)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(friendArray, id: \.self) { friend in
                            Text(friend)
                                .font(.system(size: 15))
                                .bold()
                                .padding(8)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(50)
                        }
                    }
                }
            }
            .padding(.leading, 8)
            // Image
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(record.imageList, id: \.self) { imageName in
                        Image(systemName: imageName)
                            .resizable()
                            .frame(width: 260, height: 230)
                        //                                .border(Color.black, width: 1)
                            .background(Color.black)
                            .cornerRadius(5)
                            .shadow(radius: 5, x: 5)
                    }
                }
            }
            .frame(height: 240) // ScrollView의 높이 설정
            .background(.thinMaterial)
            .shadow(radius: 3)
            // Toggle
            if toggleStatus {
                Divider()
                    .frame(width: UIScreen.main.bounds.width * 0.85, height: 1, alignment: .center)
                    .overlay(Color.gray)
                    .padding(5)
                
                // Tag
                ScrollView (.horizontal, showsIndicators: false) {
                    // 태그 배열 생성
                    let tagArray = showTag(tags: record.rTag)
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
                    .padding(.leading, 8)
                }
                .padding(.horizontal, 10)
                // Review
                Text(record.rReivew)
                    .padding(10)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    .padding(10)
                    .frame(width: UIScreen.main.bounds.width * 0.85, alignment: .leading)
            }
        }
        .padding()
        .cornerRadius(10)
        
        .onTapGesture {
            scrollIndex = record.rId
            toggleStatus.toggle()
            isFocused.toggle()
        }
        .padding(5)
    }
        
        
    } // --- Functions ---
    func showTag(tags: String) -> [String] {
        // 문자열을 쉼표로 분리
        let tagList = tags.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        
        // 중복 제거
        let uniqueTags = Array(Set(tagList))
        
        return uniqueTags
    }

    
} // End
