//
//  Created by martin on 08.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux

public struct LocationState {
    public init(longitude: String, latidude: String) {
        self.longitude = longitude
        self.latidude = latidude
    }

    public var longitude: String
    public var latidude: String
}

