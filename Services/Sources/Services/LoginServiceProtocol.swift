//
//  LoginService.swift
//  Mark
//
//  Created by martin on 11.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import Foundation

public protocol LoginServiceProtocol {
    func startAuthorization()
    func requestAccessToken(url: URL, completion: @escaping (String?) -> Void)
}
