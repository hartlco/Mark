//
//  CheckInReducer.swift
//  Mark
//
//  Created by martin on 09.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux

public func checkInReducer(state: CheckinState, action: Action) -> CheckinState {
    var state = state
    switch action {
    case let action as CheckInAction.SetCheckIn:
        state.checkedInVenue = action.venue
    default:
        break
    }

    return state
}
