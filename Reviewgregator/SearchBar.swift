//
//  SearchBar.swift
//  Reviewgregator
//
//  Created by Charles Key on 6/7/23.
//  SearchBar.swift
//  Reviewgregator

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("Search for restaurants", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button(action: {
                onSearch()
            }) {
                Image(systemName: "magnifyingglass")
                    .imageScale(.large)
                    .padding()
            }
        }
    }
}
