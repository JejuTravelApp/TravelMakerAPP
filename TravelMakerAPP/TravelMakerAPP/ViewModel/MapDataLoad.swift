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
    
    // 관광지 검색 함수
    
    
    // 식당 검색 함수
    func searchRestaurants(searchText: String) -> [RestaurantDataModel]? {
        guard let restaurants: [RestaurantDataModel] = loadJson(filename: "제주도식당Data_Test", type: [RestaurantDataModel].self) else { return nil }
        return restaurants.filter { $0.사업장명.contains(searchText) }
    }
    
    // 화장실 검색 함수
    func searchToilets(searchText: String) -> [ToiletDataModel]? {
        guard let toilets: [ToiletDataModel] = loadJson(filename: "제주공중화장실Data_전처리", type: [ToiletDataModel].self) else { return
            nil }
        return toilets.filter { $0.소재지도로명주소.contains(searchText) }
    }
    
    
    
}

