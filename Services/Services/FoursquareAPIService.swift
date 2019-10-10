//
//  Created by martin on 08.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import Foundation
#if os(watchOS)
import Constants_Watch
import Models_Watch
#else
import Constants
import Models
#endif

public final class FoursquareAPIService {
    private let baseURL = URL(string: "https://api.foursquare.com/v2/")!
    private let clientID = Credentials.clientID
    private let clientSecret = Credentials.clientSecret
    private let foursquareV = Credentials.foursquareV
    private let decoder = JSONDecoder()

    public enum Endpoint {
        case search(latitude: String, longitude: String)
        case checkin(venue: Venue, accessCode: String)
        case checkins(count: Int, accessToken: String)

        var path: String {
            switch self {
            case .search:
                return "venues/search"
            case .checkin:
                return "checkins/add"
            case .checkins:
                return "users/self/checkins"
            }
        }

        var method: String {
            switch self {
            case .search, .checkins:
                return "GET"
            case .checkin:
                return "POST"
            }
        }

        var queryItems: [URLQueryItem] {
            switch self {
            case .search(let latidude, let longitude):
                return [
                    URLQueryItem(name: "ll", value: "\(latidude),\(longitude)")
                ]
            case .checkin(let venue, let accessCode):
                return [
                    URLQueryItem(name: "venueId", value: venue.id),
                    URLQueryItem(name: "oauth_token", value: accessCode)
                ]
            case .checkins(let count, let accessToken):
                return [
                    URLQueryItem(name: "limit", value: String(count)),
                    URLQueryItem(name: "oauth_token", value: accessToken)
                ]
            }
        }
    }

    public init() { }

    public func perform<T: Codable>(endpoint: Endpoint,
                             completionHandler: @escaping (Result<T, Error>) -> Void) {
        let queryURL = baseURL.appendingPathComponent(endpoint.path)
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!

        components.queryItems = [
           URLQueryItem(name: "client_id", value: clientID),
           URLQueryItem(name: "client_secret", value: clientSecret),
           URLQueryItem(name: "v", value: foursquareV)
        ]

        components.queryItems?.append(contentsOf: endpoint.queryItems)

        var request = URLRequest(url: components.url!)
        request.httpMethod = endpoint.method
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }

            do {
                let object = try self.decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(object))
                }
            } catch let error {
                DispatchQueue.main.async {
                    #if DEBUG
                    print("JSON Decoding Error: \(error)")
                    #endif
                    completionHandler(.failure(error))
                }
            }
        }
        task.resume()
    }
}

public struct Empty: Codable {
    public init() { }
}
