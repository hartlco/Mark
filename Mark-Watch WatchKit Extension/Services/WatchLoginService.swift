//
//  WatchLoginService.swift
//  Mark-Watch WatchKit Extension
//
//  Created by martin on 15.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import Foundation
import Services

struct WatchLoginService: LoginServiceProtocol {
    func startAuthorization() {
        print("Watch: Start auth")
    }

    func requestAccessToken(url: URL, completion: @escaping (String?) -> Void) {
        print("Watch: Request Access Token")
    }
}
