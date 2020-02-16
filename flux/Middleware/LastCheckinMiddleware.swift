//
//  LastCheckinMiddleware.swift
//  flux
//
//  Created by martin on 12.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import Foundation
import SwiftUIFlux
import Services

public let loggingMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            #if DEBUG
            let name = __dispatch_queue_get_label(nil)
            let queueName = String(cString: name, encoding: .utf8)
            print("#Action: \(String(reflecting: type(of: action))) on queue: \(queueName ?? "??")")
            #endif
            return next(action)
        }
    }
}

public struct TokenMiddleware {
    let cloudKitService: CloudKitService

    public init(cloudKitService: CloudKitService = CloudKitService()) {
        self.cloudKitService = cloudKitService
    }

    public var storeTokenMiddleware: Middleware<AppState> {
        return { dispatch, getState in
            return { next in
                return { action in
                    switch action {
                    case let action as LoginAction.SetAccessCode:
                        self.cloudKitService.save(token: action.accessCode)
                    default:
                        break
                    }
                    return next(action)
                }
            }
        }
    }
}

public let lastCheckinMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            switch action {
            case let action as LoginAction.SetAccessCode:
                dispatch(CheckInAction.LoadLastCheckIn(accessToken: action.accessCode))
                next(action)
            default:
                return next(action)
            }
        }
    }
}
