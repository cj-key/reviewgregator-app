//
//  YelpService.swift
//  Reviewgregator
//
//  Created by Charles Key on 6/8/23.
// YelpService.swift
//
import Foundation
import Combine

struct YelpService {
    let apiKey = ""

    func searchYelp(address: String, completion: @escaping (Result<YelpBusiness, Error>) -> Void) {
        guard let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: "https://api.yelp.com/v3/businesses/search?location=\(encodedAddress)") else {
            completion(.failure(NSError(domain: "URL is not correct", code: 0)))
            return
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(YelpSearchResponse.self, from: data)
                    if let firstBusiness = searchResponse.businesses.first {
                        completion(.success(firstBusiness))
                    } else {
                        completion(.failure(NSError(domain: "No businesses found", code: 0)))
                    }
                } catch let error {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}

struct YelpSearchResponse: Decodable {
    let businesses: [YelpBusiness]
}

struct YelpBusiness: Identifiable, Decodable {
    let id: String
    let name: String
    let rating: Double
}

