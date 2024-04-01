//
//  RecordModel.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/24/24.
//  Description: RecordModel

import Foundation

struct RecordModel: Codable, Identifiable, Hashable {
    
    var id = UUID()
    var rId: Int
//    var rGId: Int
    var rTitle: String
    var rPhoto: [String]
    var rTag: String
    var rFriend: String
    var rReivew: String
    var rStartDate: String
    var rEndDate: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: RecordModel, rhs: RecordModel) -> Bool {
        lhs.id == rhs.id
    }

    
}
