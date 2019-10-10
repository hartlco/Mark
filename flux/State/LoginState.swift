//
//  LoginState.swift
//  Mark
//
//  Created by martin on 09.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux

public struct LoginState {
    public init(accessCode: String?) {
        self.accessCode = accessCode
    }

    public var accessCode: String?
}
