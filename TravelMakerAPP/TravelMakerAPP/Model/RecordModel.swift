//
//  RecordModel.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/24/24.
//  Description: RecordModel

import Foundation

struct RecordModel: Codable, Identifiable, Hashable {
    
    var id = UUID()
    var title: String
    var imageList: [String]
    var rTag: String
    var rStartDate: String
    var rEndDate: String
    var rFriend: String
    var rReivew: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: RecordModel, rhs: RecordModel) -> Bool {
        lhs.id == rhs.id
    }

    
}
