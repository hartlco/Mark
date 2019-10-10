//
//  HostingController.swift
//  Mark-Watch WatchKit Extension
//
//  Created by martin on 15.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI
import SwiftUIFlux
import flux_Watch
import Services_Watch

let store = Store<AppState>(reducer: appReducer,
                            middleware: [loggingMiddleware, lastCheckinMiddleware],
                            state: AppState(homeState: HomeState(venues: []),
                                            locationState: LocationState(longitude: "0", latidude: "0"),
                                            loginState: LoginState(accessCode: nil),
                                            checkInState: CheckinState(checkedInVenue: nil)))

class HostingController: WKHostingController<StoreProvider<AppState, ContentView>> {
    let updateAction = LocationAction.UpdateLocation(locationService: .shared)

    override init() {
        super.init()

        store.dispatch(action: LoginAction.GetAccessTokenFromCloudKit(cloudKitService: CloudKitService()))  
        store.dispatch(action: updateAction)
    }

    override var body: StoreProvider<AppState, ContentView> {
        let view = StoreProvider(store: store) {
                ContentView()
        }

        return view
    }
}
