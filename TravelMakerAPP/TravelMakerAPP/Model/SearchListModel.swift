//
//  SearchSave.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/21/24.
//

import Foundation

struct SearchList{
    var searchId : Int
    var searchName : String
    var searchDate : String
    
    init(searchId: Int, searchName: String, searchDate: String) {
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
