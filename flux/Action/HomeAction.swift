//
//  HomeAction.swift
//  Mark
//
//  Created by martin on 01.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux
import Models
#if os(watchOS)
import Services_Watch
#else
import Services
#endif

public struct HomeActions {
    public struct FetchVenues: AsyncAction {
        private let latidude: String
        private let longitude: String
        private let apiService: FoursquareAPIService

        public init(latidude: String,
             longitude: String,
             apiService: FoursquareAPIService = FoursquareAPIService()) {
            self.latidude = latidude
            self.longitude = longitude
            self.apiService = apiService
        }

        public func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            FoursquareAPIService().perform(endpoint: .search(latitude: latidude, longitude: longitude)) { (result: Result<SearchResponse, Error>) in
                switch result {
                case .success(let response):
                    dispatch(SetVenues(venues: response.venues))
                case .failure:
                    return
                }

            }
        }
    }

    public struct SetVenues: Action {
        public let venues: [Venue]
    }
}
