//
//  LoginService.swift
//  Mark
//
//  Created by martin on 11.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import Foundation
import Constants
import Services

final class LoginService: LoginServiceProtocol {
    func startAuthorization() {
        // TODO: Fix
        guard let visibleViewCtrl = UIApplication.shared.windows.first?.rootViewController else {
            return
        }

        FSOAuth.shared().authorizeUser(usingClientId: Credentials.clientID,
                                                    nativeURICallbackString: "markapp://foursquare",
                                                    universalURICallbackString: nil,
                                                    allowShowingAppStore: false,
                                                    presentFrom: visibleViewCtrl)
    }

    func requestAccessToken(url: URL, completion: @escaping (String?) -> Void) {
        let auth = FSOAuth.shared()
        guard let accessCode = auth.accessCode(forFSOAuthURL: url, error: nil) else { return }
        auth.requestAccessToken(forCode: accessCode,
                                clientId: Credentials.clientID,
                                callbackURIString: "markapp://foursquare",
                                clientSecret: Credentials.clientSecret) { token, _, _ in
                                    completion(token)
        }
    }


}
