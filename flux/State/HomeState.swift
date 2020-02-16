//
//  HomeState.swift
//  Mark
//
//  Created by martin on 01.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux
import Models

public struct HomeState {
    public init(venues: [Venue]) {
        self.venues = venues
    }

    public var venues: [Venue]
}
