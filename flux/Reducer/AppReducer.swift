//
//  AppReducer.swift
//  Mark
//
//  Created by martin on 01.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux

public func appReducer(state: AppState, action: Action) -> AppState {
    return AppState(homeState: homeReducer(state: state.homeState, action: action),
                    locationState: locationReducer(state: state.locationState, action: action),
                    loginState: loginReducer(state: state.loginState, action: action),
                    checkInState: checkInReducer(state: state.checkInState, action: action))
}
