//
//  LoginReducer.swift
//  Mark
//
//  Created by martin on 09.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux

public func loginReducer(state: LoginState, action: Action) -> LoginState {
    var state = state
    switch action {
    case let action as LoginAction.SetAccessCode:
        state.accessCode = action.accessCode
    default:
        break
    }

    return state
}
