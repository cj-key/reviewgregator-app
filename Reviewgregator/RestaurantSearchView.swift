//
//  ContentView.swift
//  Reviewgregator
//
//  Created by Charles Key on 6/6/23.
//
//  RestaurantSearchView.swift
//  Reviewgregator

import SwiftUI

struct RestaurantSearchView: View {
    @ObservedObject private var viewModel = RestaurantSearchViewModel()
    @State private var callCount = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search Restaurants...", text: $viewModel.searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)

                if !viewModel.places.isEmpty {
                    List(viewModel.places) { place in
                        if callCount < 20 {
                            NavigationLink(destination: RestaurantDetailView(viewModel: viewModel, place: place)) {
                                RestaurantRow(place: place, viewModel: viewModel)
                            }.onAppear {
                                callCount += 1
                            }
                        }
                    }
                } else {
                    Spacer()
                }
            }
            .navigationTitle("Restaurants")
            .onAppear {
                callCount = 0
            }
        }
    }
}
