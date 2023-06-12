//
//  RestaurantSearchViewModel.swift
//  Reviewgregator
//
//  Created by Charles Key on 6/7/23.
//
//  RestaurantSearchViewModel.swift
//  Reviewgregator

import SwiftUI
import Foundation
import Combine
import CoreLocation

enum RestaurantSearchError: Error {
    case noCandidatesFound
    case other(Error)
}

class RestaurantSearchViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var searchText = ""
    @Published var places = [Place]()
    @Published var userLocation: CLLocation?
    @Published var yelpBusiness: YelpBusiness?
    @Published var yelpCallCount = 0

    private var cancellable: AnyCancellable?
    private let googlePlacesService = GooglePlacesService()
    private let yelpService = YelpService()
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        cancellable = $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                guard let location = self?.userLocation else { return }
                self?.fetchPlaces(for: searchText, at: location)
            }
        setupLocationManager()
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func fetchPlaces(for searchText: String, at location: CLLocation) {
        googlePlacesService.searchPlaces(place: searchText, at: location) { [weak self] result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    self?.places = places
                }
            case .failure(let error):
                if let apiError = error as? RestaurantSearchError, case .noCandidatesFound = apiError {
                    print("No candidates found")
                } else {
                    print("Error fetching places: \(error.localizedDescription)")
                }
                DispatchQueue.main.async {
                    self?.places = []
                }
            }
        }
    }

    func fetchYelpBusiness(for address: String) {
        if yelpCallCount < 20 {
            yelpService.searchYelp(address: address) { [weak self] result in
                switch result {
                case .success(let yelpBusiness):
                    DispatchQueue.main.async {
                        self?.yelpBusiness = yelpBusiness
                    }
                case .failure(let error):
                    print("Error fetching Yelp business: \(error.localizedDescription)")
                }
            }
            yelpCallCount += 1
        } else {
            print("Yelp API call limit reached for this search.")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }

    func resetYelpCallCount() {
        yelpCallCount = 0
    }
}
