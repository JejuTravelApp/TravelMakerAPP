//
//  MapSearchBarView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//  Description: 지도에서 원하는 지역 검색을 위한 서치바 컴포넌트

import SwiftUI

struct MapSearchBarView: View {
    @Binding var searchText: String
    @FocusState var isFocusedTextField: Bool
    @Binding var searchResult: [RestaurantDataModel]
    var data = MapDataLoad()
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("원하는 지역을 검색해보세요!", text: $searchText) {
                if let results = data.searchRestaurants(searchText: searchText) {
                    searchResult.append(contentsOf: results)  // 배열에 다른 배열의 내용을 추가
                }
            }
            .foregroundColor(.primary)
            .focused($isFocusedTextField)
            .frame(width: UIScreen.main.bounds.width * 0.6, height: 42)
            
            // 텍스트 입력시 x 클리어 버튼 생성
            if !searchText.isEmpty {
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                }
            } else {
//                EmptyView()
                Image(systemName: "xmark.circle.fill").opacity(0) // 투명 버튼 생성
            }
            
        }
        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
        .foregroundColor(.secondary)
//        .background(Color(.secondarySystemBackground))
        .background(Color(.white))
        .cornerRadius(10.0)
    }
    
}
