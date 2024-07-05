/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A representation of a single landmark.
*/

import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var state: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    var isoutside: Bool
    var website: String
    var like: [String]

    var category: Category
    enum Category: String, CaseIterable, Codable, Identifiable {
        case Activities = "Activities"
        case Sports = "Sports"
        case Museum = "Museum"
        case Food = "Food"
        case Shopping = "Shopping"
        case Performance = "Performance"
        case Attractions = "Attractions"
        case Nature = "Nature"
        
        var readable_string: String {self.rawValue.replacingOccurrences(of: "_", with: " ")}
        
        var id: Self {self}
    }
    
    var characteristic: Characteristic
    enum Characteristic: String, CaseIterable, Codable, Identifiable {
        case Rides = "Rides"
        case Water = "Water"
        case Animals = "Animals"
        case Amusement = "Amusement"
        case Mystery = "Mystery"
        case Flying = "Flying"
        case Racing = "Racing"
        case Soccer = "Soccer"
        case Football = "Football"
        case Baseball = "Baseball"
        case Basketball = "Basketball"
        case Golf = "Golf"
        case Music = "Music"
        case History = "History"
        case Art = "Art"
        case Science = "Science"
        case Money = "Money"
        case Beer = "Beer"
        case Barbecue = "Barbecue"
        case Market = "Market"
        case Chocolate = "Chocolate"
        case Garden = "Garden"
        case Indoors = "Indoors"
        case Outdoors = "Outdoors"
        case Entertainment = "Entertainment"
        case Theater = "Theater"
        case Trucks = "Trucks"
        case Big_Things = "Big_Things"
        case Small_Things = "Small_Things"
        case Rocks = "Rocks"

        var readable_string: String {self.rawValue.replacingOccurrences(of: "_", with: " ")}
        
        var id: Self {self}
    }

    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    var featureImage: Image? {
        isFeatured ? Image(imageName + "_feature") : nil
    }

    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
