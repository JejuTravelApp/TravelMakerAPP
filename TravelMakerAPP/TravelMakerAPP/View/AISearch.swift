//
//  HomeViewTest.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/21/24.
//

import SwiftUI

struct AISearch: View {
    
    @State var searchText : String //TextField에 검색한 내용. => DetailView로 전송
    @State var showDetail : Bool = false //sheet(DetailView)를 띄울 때 사용할 상태변수.

    ///searchbar 변수
//    @FocusState var isTextFieldFocused : Bool //키보드
    
    @State var testList = ["test1", "test2", "test3", "test4", "test5", "test6"]
    
    var body: some View {
        VStack(spacing:0){
            
            Image("JejuAiModel")
                .resizable()
                .frame(width: 120, height: 120)
            
            
//            ///SEARCH BAR Start
            AISearchBar(text: $searchText)
//            ///SearchBar End
            // 해시태그
                VStack(spacing: 20) {
                    HStack(spacing: 10) {
                        ForEach(0..<3, id: \.self) { index in
                            Button(testList[index]) {
                                searchText = (testList[index])
                                searchAction(searchData: searchText)
                            }
                            .fontWeight(.bold)
                            .buttonStyle(.bordered)
                        }
                    }
                    HStack(spacing: 10) {
                        ForEach(3..<6, id: \.self) { index in
                            Button(testList[index]) {
                                searchText = (testList[index])
                                searchAction(searchData: searchText)
                            }
                            .fontWeight(.bold)
                            .buttonStyle(.bordered)
                        }
                    }
                }
                .padding(20)
        }
    }
    //====== func ======
//     searchAction이 들어갈 함수
    func searchAction(searchData: String){
        showDetail = true
    }
    
    
    
    
    
}

