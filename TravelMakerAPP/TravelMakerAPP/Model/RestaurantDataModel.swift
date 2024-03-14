//
//  RestaurantDataModel.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//  Description: 식당 데이터를 받아올 때 JSON의 Key값을 맞춰서 원하는 형태로 출력해주기 위한 Model

import Foundation

struct RestaurantDataModel: Codable, Identifiable, Hashable {
    var id: UUID
    var 사업장명: String
    var foodCategory: String
    var 도로명전체주소: String
    var rating: String
    var visitReviewCount: String
    var blogReviewCount: String
    var images: String
    var lat: String
    var lng: String

    enum CodingKeys: String, CodingKey {
        case 사업장명
        case foodCategory
        case 도로명전체주소
        case rating
        case visitReviewCount
        case blogReviewCount
        case images
        case lat
        case lng
    }

    // CodingKey 프로토콜을 준수하는 열거형을 정의하여 'id'를 디코딩하지 않도록 설정
    // 초기화 메소드에서 필요에 따라 'id'를 생성
    init(사업장명: String, foodCategory: String, 도로명전체주소: String, rating: String, visitReviewCount: String, blogReviewCount: String, images: String, lat: String, lng: String) {
        self.id = UUID()
        self.사업장명 = 사업장명
        self.foodCategory = foodCategory
        self.도로명전체주소 = 도로명전체주소
        self.rating = rating
        self.visitReviewCount = visitReviewCount
        self.blogReviewCount = blogReviewCount
        self.images = images
        self.lat = lat
        self.lng = lng
    }

    // Decodable 프로토콜을 준수하는 이니셜라이저는 'id'를 자동으로 생성
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.사업장명 = try container.decode(String.self, forKey: .사업장명)
        self.foodCategory = try container.decode(String.self, forKey: .foodCategory)
        self.도로명전체주소 = try container.decode(String.self, forKey: .도로명전체주소)
        self.rating = try container.decode(String.self, forKey: .rating)
        self.visitReviewCount = try container.decode(String.self, forKey: .visitReviewCount)
        self.blogReviewCount = try container.decode(String.self, forKey: .blogReviewCount)
        self.images = try container.decode(String.self, forKey: .images)
        self.lat = try container.decode(String.self, forKey: .lat)
        self.lng = try container.decode(String.self, forKey: .lng)
        self.id = UUID()
    }
    
}
