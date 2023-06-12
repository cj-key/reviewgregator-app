//  GooglePlacesService.swift
//  Reviewgregator
//
//  Created by Charles Key on 6/7/23.
// GooglePlacesService.swift

//
//  GooglePlacesService.swift
//  Reviewgregator
//

import Foundation
import Combine
import CoreLocation

struct Place: Identifiable, Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case rating
        case vicinity
    }
    
    let id = UUID()
    let name: String
    let rating: Double
    let vicinity: String  // Adjusted for Google Places API
}


struct SearchResponse: Decodable {
    let results: [Place]
}

struct GooglePlacesService {
    func searchPlaces(place: String, at location: CLLocation, completion: @escaping (Result<[Place], Error>) -> Void){
        let apiKey = ""
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        guard
            let encodedPlace = place.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=5000&keyword=\(encodedPlace)&key=\(apiKey)")
        else {
            completion(.failure(NSError(domain: "URL is not correct", code: 0)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                    completion(.success(searchResponse.results))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}
