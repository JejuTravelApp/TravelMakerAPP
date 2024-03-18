//
//  ImageLoad.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/17/24.
//  Description: 네트워크 형식의 이미지를 정규식을통해 뽑기위한 클래스

import Foundation

class ImageLoad {
    // 이미지 받아온 String값을 뽑아서 URL로 목록을 추출하는 함수
    func extractImageUrls(from imagesString: String) -> [URL] {
        // 정규 표현식을 사용해서 URL을 찾기
        let pattern = "(https?:\\/\\/.*?)(\"|\\s|$)"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        
        let nsString = imagesString as NSString
        let results = regex.matches(in: imagesString,
                                    range: NSRange(location: 0, length: nsString.length))
        
        // 추출된 URL 문자열을 실제 URL 배열로 변환
        return results.compactMap { result in
            let urlString = nsString.substring(with: result.range(at: 1))
            return URL(string: urlString)
        }
    }

}
