//
//  PlaceRow.swift
//  Reviewgregator
//
//  Created by Charles Key on 6/7/23.
//

//  RestaurantRow.swift
//  Reviewgregator

import SwiftUI

struct RestaurantRow: View {
    var place: Place
    @ObservedObject var viewModel: RestaurantSearchViewModel
    
    init(place: Place, viewModel: RestaurantSearchViewModel) {
        self.place = place
        self.viewModel = viewModel
        viewModel.fetchYelpBusiness(for: place.vicinity) // Fetch Yelp score when row is populated
    }
    
    var body: some View {
        HStack {
            Text(place.name)
            
            Spacer()
            
            if let yelpBusiness = viewModel.yelpBusiness {
                Text("Reviewgregation: \(calculateReviewgregatorScore(), specifier: "%.1f")")
                    .font(.subheadline)
            } else {
                Text("Reviewgregation: ?")
                    .font(.subheadline)
            }
        }
    }
    
    private func calculateReviewgregatorScore() -> Double {
        let googleRating = place.rating
        let yelpRating = viewModel.yelpBusiness?.rating ?? 0.0
        
        let averageRating = (googleRating + yelpRating) / 2.0
        
        return averageRating
    }
}

