//
//  HomeReducer.swift
//  Mark
//
//  Created by martin on 01.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux

public func homeReducer(state: HomeState, action: Action) -> HomeState {
    var state = state
    switch action {
    case let action as HomeActions.SetVenues:
        state.venues = action.venues
    default:
        break
    }

    return state
}
