//
//  SearchSave.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/21/24.
//

import Foundation

struct SearchList : Identifiable{
    var id : Int //식별자로 사용할 속성
    var searchId : Int
    var searchName : String
    var searchDate : Date
    
    init(id : Int, searchId: Int, searchName: String, searchDate: Date) {
        self.id = searchId
        self.searchId = searchId
        self.searchName = searchName
        self.searchDate = searchDate
    }
}
//ID값 부여
extension SearchList : Hashable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(searchId)
    }
}
//struct SomeData: Identifiable {
//    var searchDataName: String
//    var searchDataDate: String
//    var id: String { self.searchDataName }
//}



