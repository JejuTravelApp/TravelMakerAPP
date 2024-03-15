//
//  TouristDataModel.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/15/24.
//  Description: 관광지 데이터를 받아올 때 JSON의 Key값을 맞춰서 원하는 형태로 출력해주기 위한 Model

import Foundation

struct TouristDataModel: Codable, Identifiable, Hashable {
    var id: UUID
    var title: String
    var category: String
    var introduction: String
    var address: String
    var roadaddress: String
    var latitude: Double
    var longitude: Double
    var phoneno: String
    var imgpath: String
    var tag: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case category
        case introduction
        case address
        case roadaddress
        case latitude
        case longitude
        case phoneno
        case imgpath
        case tag
    }
    
    init(title: String, category: String, introduction: String, address: String, roadaddress: String, latitude: Double, longitude: Double, phoneno: String, imgpath: String, tag: String) {
        self.id = UUID()
        self.title = title
        self.category = category
        self.introduction = introduction
        self.address = address
        self.roadaddress = roadaddress
        self.latitude = latitude
        self.longitude = longitude
        self.phoneno = phoneno
        self.imgpath = imgpath
        self.tag = tag
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.category = try container.decode(String.self, forKey: .category)
        self.introduction = try container.decode(String.self, forKey: .introduction)
        self.address = try container.decode(String.self, forKey: .address)
        self.roadaddress = try container.decode(String.self, forKey: .roadaddress)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.phoneno = try container.decode(String.self, forKey: .phoneno)
        self.imgpath = try container.decode(String.self, forKey: .imgpath)
        self.tag = try container.decode(String.self, forKey: .tag)
        self.id = UUID()
    }
}
