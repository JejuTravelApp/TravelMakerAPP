//
//  MarkerModel.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 4/7/24.
//

import Foundation

struct MarkerModel: Decodable {
    let hmid: Int
    let hmname: String
    let hmlatitude: Double
    let hmlongitude: Double

    }

// HashCode: 무조건 Unique한 값임
extension MarkerModel: Hashable {
    func hash(into hasher: inout Hasher) {
        // StudentJSON 모델의 hmid값을 id값으로 사용하겠다 선언 (대신에 code는 Unique해야함)
        hasher.combine(hmid)
    }
}

