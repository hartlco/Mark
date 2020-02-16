//
//  LoginAction.swift
//  Mark
//
//  Created by martin on 09.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUIFlux
import KeychainAccess
import Constants
import Foundation
#if os(watchOS)
import Services_Watch
#else
import Services
#endif

public struct LoginAction {
    public struct ShowLogin: AsyncAction {
        public init(loginServie: LoginServiceProtocol) {
            self.loginServie = loginServie
        }

        let loginServie: LoginServiceProtocol

        public func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            loginServie.startAuthorization()
        }
    }

    public struct ExtractAccessCode: AsyncAction {
        public init(url: URL,
                    loginService: LoginServiceProtocol) {
            self.url = url
            self.loginService = loginService
        }

        let url: URL
        let loginService: LoginServiceProtocol
        
        public func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            loginService.requestAccessToken(url: url) { token in
                guard let token = token else { return }
                try? Keychain(accessGroup: KeychainConstants.accessGroup)
                    .set(token, key: KeychainConstants.token)
                dispatch(SetAccessCode(accessCode: token))
            }
        }
    }

    public struct GetAccessCodeFromKeychain: AsyncAction {
        public init(loginServie: LoginServiceProtocol) {
            self.loginServie = loginServie
        }

        let loginServie: LoginServiceProtocol

        public func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            guard let accessCode = try? Keychain(accessGroup: KeychainConstants.accessGroup)
                .get(KeychainConstants.token) else {
                dispatch(ShowLogin(loginServie: loginServie))
                return
            }
            dispatch(SetAccessCode(accessCode: accessCode))
        }
    }

    public struct GetAccessTokenFromCloudKit: AsyncAction {
        let cloudKitService: CloudKitService

        public init(cloudKitService: CloudKitService) {
            self.cloudKitService = cloudKitService
        }

        public func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            cloudKitService.getToken { token in
                guard let token = token else { return }
                dispatch(SetAccessCode(accessCode: token))
            }
        }
    }

    public struct SetAccessCode: Action {
        public init(accessCode: String) {
            self.accessCode = accessCode
        }

        public let accessCode: String
    }
}
