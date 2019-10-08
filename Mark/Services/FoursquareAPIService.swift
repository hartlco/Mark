//
//  Created by martin on 08.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import Foundation

final class FoursquareAPIService {
    private let baseURL = URL(string: "https://api.foursquare.com/v2/venues/")!
    private let clientID = "HB53I3XPM35C0DTEJM3JLSAWMWWBDWIUQC2L5SP3K0W4NTKI"
    private let clientSecret = "H1XBXTBCHC11RMMDHBTY4IW5ANWZMFTUCOUCNTPSUMRBNDPC"
    private let foursquareV = "20190425"
    private let decoder = JSONDecoder()

    enum Endpoint {
        case search(latitude: String, longitude: String)

        var path: String {
            switch self {
            case .search:
                return "search"
            }
        }

        var method: String {
            switch self {
            case .search:
                return "GET"
            }
        }

        var queryItems: [URLQueryItem] {
            switch self {
            case .search(let latidude, let longitude):
                return [
                    URLQueryItem(name: "ll", value: "\(latidude),\(longitude)")
                ]
            }
        }
    }

    func perform<T: Codable>(endpoint: Endpoint,
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
