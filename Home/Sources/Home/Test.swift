//
//  File.swift
//  
//
//  Created by Kevin on 6/14/23.
//

import Foundation

public class DBHome: ObservableObject {
    @Published var landmarks: [HomeModel] = load("landmarkData.json")
    public init(landmarks: [HomeModel]) {
        self.landmarks = load("landmarkData.json")
    }

}

func load<T: Decodable>(_ filename: String) -> T {
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
