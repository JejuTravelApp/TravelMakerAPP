//
//  TourDataLoad.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/18/24.
//

import Foundation

class TourDataLoad{
    
    func load<T: Decodable>(filename: String, type:T.Type) -> T? {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
