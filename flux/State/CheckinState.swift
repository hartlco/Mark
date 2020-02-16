//
//  CheckinState.swift
//  Mark
//
//  Created by martin on 09.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux
import Models

public struct CheckinState {
    public init(checkedInVenue: Venue?) {
        self.checkedInVenue = checkedInVenue
    }

    public var checkedInVenue: Venue?
}
