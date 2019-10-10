//
//  Created by martin on 08.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux
#if os(watchOS)
import Services_Watch
#else
import Services
#endif
import Combine

public struct LocationAction {
    public class UpdateLocation: AsyncAction {
        var cancellable: AnyCancellable?
        private let locationService: LocationUpdateService

        public init(locationService: LocationUpdateService) {
            self.locationService = locationService
        }

        public func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            cancellable = LocationUpdateService.shared.$location.sink(receiveCompletion: { _ in
                return
            }) { location in
                guard let location = location else { return }
                let action = LocationAction.SetLocation(longitude: String(location.coordinate.longitude),
                                                        latitude: String(location.coordinate.latitude))
                dispatch(action)
            }
        }
    }

    public struct SetLocation: Action {
        public init(longitude: String, latitude: String) {
            self.longitude = longitude
            self.latitude = latitude
        }

        let longitude: String
        let latitude: String
    }
}
