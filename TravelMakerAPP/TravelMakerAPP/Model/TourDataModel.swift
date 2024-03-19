//
//  Tour.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/18/24.
//

import Foundation
//우선 각각의 객체에 키값을 부여하기 위해 Identifiable 프로토콜을 사용하였고, id 를 UUID() 로 생성해주었다. 또한 JSON 에서 읽어온 데이터를 변환하기 위해서 Codable 프로토콜도 사용하였다.
//그리고 각각의 항목들에 대해 선언해주었다.
struct TourDataModel: Hashable, Identifiable, Codable{
    var id : UUID
    var title : String
    var stars : String
    var mainTag : String
    var subTag : String
    var text : String
    var BodyRightText : String
    
    enum CodingKeys: String, CodingKey{
        case title
        case stars
        case mainTag
        case subTag
        case text
        case BodyRightText
    }
    init(title: String, stars: String, mainTag: String, subTag: String, text: String, BodyRightText: String) {
        self.id = UUID()
        self.title = title
        self.stars = stars
        self.mainTag = mainTag
        self.subTag = subTag
        self.text = text
        self.BodyRightText = BodyRightText
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.title = try container.decode(String.self, forKey: .title)
        self.stars = try container.decode(String.self, forKey: .stars)
        self.mainTag = try container.decode(String.self, forKey: .mainTag)
        self.subTag = try container.decode(String.self, forKey: .subTag)
        self.text = try container.decode(String.self, forKey: .text)
        self.BodyRightText = try container.decode(String.self, forKey: .BodyRightText)
    }
    
}
