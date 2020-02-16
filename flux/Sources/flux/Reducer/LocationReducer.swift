//
//  LocationReducer.swift
//  Mark
//
//  Created by martin on 08.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux

public func locationReducer(state: LocationState, action: Action) -> LocationState {
    var state = state
    switch action {
    case let action as LocationAction.SetLocation:
        state.longitude = action.longitude
        state.latidude = action.latitude
    default:
        break
    }
    return state
}
