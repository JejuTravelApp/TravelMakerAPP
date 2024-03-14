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
    func loadRestaurantsJson(filename fileName: String) -> [RestaurantDataModel]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([RestaurantDataModel].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    
    // 식당 검색 함수
    func searchRestaurants(searchText: String) -> [RestaurantDataModel]? {
        guard let restaurants = loadRestaurantsJson(filename: "제주도식당Data_Test") else { return nil }
        return restaurants.filter { $0.사업장명.contains(searchText) }
    }
    
    // 화장실 검색 함수
//    func searchToilets() ->

}

