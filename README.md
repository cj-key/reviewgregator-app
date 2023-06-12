# reviewgregator_app
An IOS app designed to easily see a restaurant's different scores from various sites.
# Reviewgregator
## Table of Contents
1. [Introduction](#introduction)
2. [Video Tutorial](#video-tutorial)
2. [Technologies Used](#technologies-used)
3. [Installation Instructions](#installation-instructions)
4. [Code Examples](#code-examples)
5. [Features](#features)
6. [License](#license)
7. [Contact](#contact)
## Introduction
Reviewgregator aims to save users time when searching for restaurant reviews by aggregating ratings from Google and Yelp into one single rating. This app was inspired by the constant need of wanting to see all ratings in one place when exploring new places to eat. The app uses the user's current location to display restaurants nearby.
## Video Tutorial

[Click Me](https://cj-key.github.io/reviewgregator_app/)

## Technologies Used
Reviewgregator is built with:
- **Xcode**: The official integrated development environment for developing iOS apps.
- **Swift**: A powerful and intuitive programming language for iOS.
- **SwiftUI**: For building the user interface.
- **Combine**: For handling asynchronous events with declarative code.
- **CoreLocation**: To access the user's location.
- **Google Places API**: To search for restaurants and retrieve Google ratings.
- **Yelp API**: To search for restaurants and retrieve Yelp ratings.
## Installation Instructions
To install and run Reviewgregator on your local machine, follow these steps:
1. Make sure you have Xcode installed on your Mac. You can install it from the Mac App Store.
2. Clone the repository to your local machine:
   ```
   git clone https://github.com/yourusername/reviewgregator.git
   ```
3. Open the project in Xcode:
   ```
   open reviewgregator/Reviewgregator.xcodeproj
   ```
4. Go to the `GooglePlacesService.swift` file and replace the empty `apiKey` variable with your Google Places API key.
5. Similarly, go to the `YelpService.swift` file and replace the empty `apiKey` variable with your Yelp API key.
6. Build and run the app by pressing `Cmd + R` or clicking on the play button in the top left corner of Xcode.
## Code Examples
Here's how Reviewgregator fetches restaurants from Google Places in `GooglePlacesService.swift`:
```swift
func searchPlaces(place: String, at location: CLLocation, completion: @escaping (Result<[Place], Error>) -> Void){
    let apiKey = "Your Google Places API Key Here"
    let latitude = location.coordinate.latitude
    let longitude = location.coordinate.longitude
    guard
        let encodedPlace = place.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=5000&keyword=\(encodedPlace)&key=\(apiKey)")
    else {
        completion(.failure(NSError(domain: "URL is not correct", code: 0)))
        return
    }
    // Rest of the code to fetch data
}
```
## Features
- **Search for Restaurants**: Users can search for restaurants by name. The app will use the user's current location to find nearby restaurants.
- **View Restaurant Details**: When selecting a restaurant from the search results, the user will see detailed information including the name, aggregated rating, and address.
- **Aggregated Ratings**: Reviewgregator calculates an aggregated rating based on the Google and Yelp ratings.
- **Location-Based**: The app uses the user’s current location to find restaurants nearby.
## License
This project is open-source and available under the [MIT License](https://opensource.org/licenses/MIT).
## Contact
[C.J. Key ](https://www.linkedin.com/in/cj-key-8a386915a/)


