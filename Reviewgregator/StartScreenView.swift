//
//  StartScreenView.swift
//  Reviewgregator
//
//  Created by Charles Key on 6/12/23.
//

import SwiftUI
import Foundation

struct StartScreenView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                GeometryReader { geometry in
                    VStack {
                        
                        Text("Reviewgregator")
                            .padding(.top, 20)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .italic() // Make the app name in italics
                            .frame(width: geometry.size.width) // Adjust width to full width of the screen
                        
                        VStack(spacing: 20) {
                            Text("(🌮 + 🍕) / 🍔")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            VStack {
                                Spacer() // Push the content to the middle
                                
                                NavigationLink(destination: RestaurantSearchView()) {
                                    Text("Tap to Search")
                                        .font(.title)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .foregroundColor(.black)
                                }
                                
                                Spacer() // Push the content to the middle
                            }
                        }
                    }
                }
            }
        }
    }
}
