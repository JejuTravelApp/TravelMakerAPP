//
//  AISearchBar_real.swift
//  TravelMakerAPP
//
//  Created by ms k on 4/4/24.
//

import SwiftUI

struct AISearchBar_real: View {
    
// FIELD
    
    @State private var searchText : String = ""
    @FocusState private var isTextFieldFocused : Bool
    
//테스트 List 추후 db로 대체
    let exampleSearchList: [SearchList] = [
        SearchList(id: 1, searchId: 101, searchName: "New York", searchDate: Date()),
        SearchList(id: 2, searchId: 102, searchName: "Paris", searchDate: Date()),
        SearchList(id: 3, searchId: 103, searchName: "Tokyo", searchDate: Date()),
        SearchList(id: 4, searchId: 104, searchName: "London", searchDate: Date()),
        SearchList(id: 5, searchId: 105, searchName: "Rome", searchDate: Date()),
        SearchList(id: 6, searchId: 106, searchName: "Seoul", searchDate: Date()),
        SearchList(id: 7, searchId: 107, searchName: "Busan", searchDate: Date()),
        SearchList(id: 8, searchId: 108, searchName: "Sydney", searchDate: Date()),
        SearchList(id: 9, searchId: 109, searchName: "Melburn", searchDate: Date())
    ]
    
// searchText를 exampleSearchList와 실시간으로 데이터 검사하는 변수.
    var searchResults : [String] {
        if searchText.isEmpty{
            print("searchText없다.")
            return exampleSearchList.map { $0.searchName }
        } else{
            print("searchText있다.")
            return exampleSearchList.filter{
                $0.searchName.contains(searchText)
            }.map{$0.searchName}
            
        }
    }
    
// BODY
    
    var body: some View {
        VStack{
            NavigationStack{
                List{
                    ForEach(searchResults, id: \.self){result in
                        NavigationLink{
                            Text(result)
                        } label:{
                            Text(result)
                        }
                    }
//                    .background(Color.blue.opacity(0.5))
                }
            }
            .searchable(text: $searchText, prompt: "검색어를 입력하세요")
        }
        
    }//BODY
    
// ==================Function=========================
    
    
}//AISearchBar_real

