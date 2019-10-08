//
//  AppReducer.swift
//  Mark
//
//  Created by martin on 01.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux

func appReducer(state: AppState, action: Action) -> AppState {
    return AppState(homeState: homeReducer(state: state.homeState, action: action))
}
