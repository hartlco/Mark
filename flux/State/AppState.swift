//
//  AppState.swift
//  Mark
//
//  Created by martin on 01.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux

public struct AppState: FluxState {
    public init(homeState: HomeState, locationState: LocationState, loginState: LoginState, checkInState: CheckinState) {
        self.homeState = homeState
        self.locationState = locationState
        self.loginState = loginState
        self.checkInState = checkInState
    }

    public var homeState: HomeState
    public var locationState: LocationState
    public var loginState: LoginState
    public var checkInState: CheckinState
}
