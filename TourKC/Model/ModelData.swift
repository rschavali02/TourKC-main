/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Storage for model data.
*/

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    var w: WResult?
    @Published var shown: String = ""
    
    init() {
        let defaults = UserDefaults.standard
        WeatherService.shared.getWeather() { items in
            self.w = items
        }
        //print(self.w!)
        var new_mark: [Landmark] = []
        for var i: Landmark in landmarks {
            i.isFavorite = defaults.bool(forKey: i.name + "_fav")
            new_mark.append(i)
        }
        landmarks = new_mark
    }

    var features: [Landmark] {
        //let w: WResult? = WeatherService.shared.getWeather()
        if let _: WResult = self.w {
            return landmarks.filter { $0.isFeatured } .filter { $0.isoutside && w!.main.feels_like >= 50 || !$0.isoutside && w!.main.feels_like < 50 }
        } else {
            return landmarks.filter { $0.isFeatured }
        }
    }
    
    func isWeatherPermit(_ mark: Landmark) -> Bool {
        return mark.isoutside && w!.main.feels_like >= 50 || !mark.isoutside && w!.main.feels_like < 50
    }

    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
    
    func names2landmark(names: [String]) -> [Landmark] {
        var ret: [Landmark] = []
        for i in names {
            for n in landmarks {
                if (n.name == i) {
                    ret.append(n)
                }
            }
        }
        return ret
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
