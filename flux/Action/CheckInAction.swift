//
//  CheckInAction.swift
//  Mark
//
//  Created by martin on 09.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux
import Models
import Services

public struct CheckInAction {
    public struct CheckIn: AsyncAction {
        public init(venue: Venue, accessCode: String?) {
            self.venue = venue
            self.accessCode = accessCode
        }

        let venue: Venue
        let accessCode: String?

        public func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            guard let accessCode = accessCode else { return }

            FoursquareAPIService().perform(endpoint: .checkin(venue: venue, accessCode: accessCode)) { (result: Result<Empty, Error>) in
                /// TODO: retain cycle
                dispatch(SetCheckIn(venue: self.venue))
            }
        }
    }

    public struct LoadLastCheckIn: AsyncAction {
        let accessToken: String

        public func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            FoursquareAPIService()
                .perform(endpoint: .checkins(count: 1,
                                             accessToken: accessToken)) { (result: Result<LastCheckInsResponse, Error>)  in
                                                switch result {
                                                case .success(let lastCheckinResponse):
                                                    guard let lastVenue = lastCheckinResponse.venues.first else { return }
                                                    dispatch(SetCheckIn(venue: lastVenue))
                                                case .failure:
                                                    return
                                                }
            }
        }
    }

    struct SetCheckIn: Action {
        public init(venue: Venue) {
            self.venue = venue
        }

        let venue: Venue
    }
}
