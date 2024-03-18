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
    @Binding var restaurantResult: [RestaurantDataModel] // 식당 검색 결과
    @Binding var touristResult: [TouristDataModel] // 관광지, 쇼핑 검색 결과
    @Binding var toiletResult: [ToiletDataModel] // 화장실 검색 결과 성산일출봉
    
    var data = MapDataLoad()
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .onTapGesture {
                    searchAction()
                }
            
            TextField("관광지•음식점 검색", text: $searchText) {
                searchAction()
            }
            .foregroundColor(.primary)
            .focused($isFocusedTextField)
            .frame(width: UIScreen.main.bounds.width * 0.6, height: 40)
            
            
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
    // --- Functions ---
    // 검색 함수
    func searchAction() {
        restaurantResult = []
        touristResult = []
        toiletResult = []
        
        if let restaurantResults = data.searchRestaurants(searchText: searchText) {
            restaurantResult.append(contentsOf: restaurantResults)  // 배열에 다른 배열의 내용을 추가
        }
        if let touristResults = data.searchTouristsData(searchText: searchText) {
            touristResult.append(contentsOf: touristResults)
        }
        if let toiletResults = data.searchToilets() {
            toiletResult.append(contentsOf: toiletResults)
        }
        
        isFocusedTextField = false
        
    }
    
} // End
