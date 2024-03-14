//
//  ToiletDataModel.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//  Description: 화장실 데이터를 받아올 때 JSON의 Key값을 맞춰서 원하는 형태로 출력해주기 위한 Model

import Foundation

struct ToiletDataModel: Codable, Identifiable, Hashable {
    
    var id: UUID
    var 화장실명: String
    var 소재지도로명주소: String
    var 남성용_장애인용대변기수: Int
    var 남성용_장애인용소변기수: Int
    var 여성용_장애인용대변기수: Int
    var 개방시간상세: String
    var WGS84위도: String
    var WGS84경도: String
    var 비상벨설치여부: String
    var 비상벨설치장소: String
    var 기저귀교환대유무: String
    var 기저귀교환대장소: String

    enum CodingKeys: String, CodingKey {
        case 화장실명
        case 소재지도로명주소
        case 남성용_장애인용대변기수
        case 남성용_장애인용소변기수
        case 여성용_장애인용대변기수
        case 개방시간상세
        case WGS84위도
        case WGS84경도
        case 비상벨설치여부
        case 비상벨설치장소
        case 기저귀교환대유무
        case 기저귀교환대장소
    }
    
    init(화장실명: String, 소재지도로명주소: String, 남성용_장애인용대변기수: Int, 남성용_장애인용소변기수:Int, 여성용_장애인용대변기수: Int, 개방시간상세: String, WGS84위도: String, WGS84경도: String, 비상벨설치여부: String, 비상벨설치장소: String, 기저귀교환대유무: String, 기저귀교환대장소: String) {
        self.id = UUID()
        self.화장실명 = 화장실명
        self.소재지도로명주소 = 소재지도로명주소
        self.남성용_장애인용대변기수 = 남성용_장애인용대변기수
        self.남성용_장애인용소변기수 = 남성용_장애인용소변기수
        self.여성용_장애인용대변기수 = 여성용_장애인용대변기수
        self.개방시간상세 = 개방시간상세
        self.WGS84위도 = WGS84위도
        self.WGS84경도 = WGS84경도
        self.비상벨설치여부 = 비상벨설치여부
        self.비상벨설치장소 = 비상벨설치장소
        self.기저귀교환대유무 = 기저귀교환대유무
        self.기저귀교환대장소 = 기저귀교환대장소
    }

    
    // 항목이 수정되었으니, 이전에 사용한 초기화 방법은 제거하고 코딩키에 맞는 새로운 초기화 메소드를 정의합니다.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.화장실명 = try container.decode(String.self, forKey: .화장실명)
        self.소재지도로명주소 = try container.decode(String.self, forKey: .소재지도로명주소)
        self.남성용_장애인용대변기수 = try container.decode(Int.self, forKey: .남성용_장애인용대변기수)
        self.남성용_장애인용소변기수 = try container.decode(Int.self, forKey: .남성용_장애인용소변기수)
        self.여성용_장애인용대변기수 = try container.decode(Int.self, forKey: .여성용_장애인용대변기수)
        self.개방시간상세 = try container.decode(String.self, forKey: .개방시간상세)
        self.WGS84위도 = try container.decode(String.self, forKey: .WGS84위도)
        self.WGS84경도 = try container.decode(String.self, forKey: .WGS84경도)
        self.비상벨설치여부 = try container.decode(String.self, forKey: .비상벨설치여부)
        self.비상벨설치장소 = try container.decode(String.self, forKey: .비상벨설치장소)
        self.기저귀교환대유무 = try container.decode(String.self, forKey: .기저귀교환대유무)
        self.기저귀교환대장소 = try container.decode(String.self, forKey: .기저귀교환대장소)
        self.id = UUID()
    }
    
    // 다른 사용자 정의 초기화 메소드는 필요에 따라 추가하되, 새 구조에 맞게 조정해야 합니다.
}

