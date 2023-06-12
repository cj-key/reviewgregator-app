//
//  RestaurantDetailView.swift
//  Reviewgregator
//
//  RestaurantDetailView.swift
//  Reviewgregator

import SwiftUI

struct RestaurantDetailView: View {
    @ObservedObject var viewModel: RestaurantSearchViewModel
    var place: Place
    
    var body: some View {
        VStack {
            // Name and Reviewgregator Score at the top
            VStack {
                Text(place.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Reviewgregation: \(calculateReviewgregatorScore(), specifier: "%.1f")")
                    .font(.subheadline)
                    .padding(.top)
            }
            
            Spacer()
            
            // Google Rating in the middle
            Text("Google Rating: \(place.rating, specifier: "%.1f")")
                .font(.title2)
            
            // Display Yelp rating if available
            if let yelpBusiness = viewModel.yelpBusiness {
                Text("Yelp Score: \(yelpBusiness.rating, specifier: "%.1f")")
                    .font(.title2)
            }

            Spacer()

            // Address at the bottom
            Text("Address: \(place.vicinity)")  // changed from place.formattedAddress
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.bottom)

        }
        .padding()
        .onAppear {
            viewModel.fetchYelpBusiness(for: place.vicinity) // changed from place.formattedAddress
        }
    }
    
    private func calculateReviewgregatorScore() -> Double {
        let googleRating = place.rating
        let yelpRating = viewModel.yelpBusiness?.rating ?? 0.0
        
        let averageRating = (googleRating + yelpRating) / 2.0
        
        return averageRating
    }
}
