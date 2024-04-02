//
//  MapDataLoad.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//  Description: 지도에서 검색했을 때 JSON파일을 조회해서 결과를 리턴해주는 ViewModel

import Foundation
import MapKit

class MapDataLoad {
    // json파일을 load하는 함수
    // 제네릭 타입을 사용한 JSON 로드 및 디코드 함수
    func loadJson<T: Decodable>(filename fileName: String, type: T.Type) -> T? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    // 범용적인 검색 함수
    func searchData<T: Decodable & Searchable>(searchText: String, filename: String, type: T.Type) -> [T]? {
        guard let data: [T] = loadJson(filename: filename, type: [T].self) else { return nil }
        return data.filter { $0.matches(searchText: searchText) }
    }
    
    // 모든 데이터를 반환하는 함수
    func loadAllData<T: Decodable>(filename: String, type: T.Type) -> T? {
        return loadJson(filename: filename, type: type)
    }
    // 반려동물 동반 카테고리 버튼 함수
    func searchAnimalData() -> [TouristDataModel]? {
        guard let tourists: [TouristDataModel] = loadJson(filename: "제주도관광지Data_test", type: [TouristDataModel].self) else { return nil }
        return tourists.filter { $0.tag.contains("반려동물") }
    }
    
    // 화장실 검색 함수
    func searchToilets() -> [ToiletDataModel]? {
        guard let toilets: [ToiletDataModel] = loadJson(filename: "제주공중화장실Data_전처리", type: [ToiletDataModel].self) else { return
            nil }
        return toilets
    }
}

// 검색 가능한 데이터 모델을 위한 프로토콜
protocol Searchable {
    func matches(searchText: String) -> Bool
}

// TouristDataModel이 Searchable 프로토콜을 준수하도록 확장
extension TouristDataModel: Searchable {
    func matches(searchText: String) -> Bool {
        return title.contains(searchText) || category.contains(searchText) || tag.contains(searchText)
    }
}

// RestaurantDataModel이 Searchable 프로토콜을 준수하도록 확장
extension RestaurantDataModel: Searchable {
    func matches(searchText: String) -> Bool {
        return 사업장명.contains(searchText)
    }
}
