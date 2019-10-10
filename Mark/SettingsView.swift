//
//  SettingsView.swift
//  Mark
//
//  Created by martin on 16.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUI
import flux
import SwiftUIFlux
import Models

struct SettingsView: ConnectedView {
    struct Props {
        let longitude: String
        let latitude: String
        let venues: [Venue]
        let accessToken: String?
        let checkedInVenue: Venue?
        let dispatch: DispatchFunction
    }

    func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
        return Props(longitude: state.locationState.longitude,
                     latitude: state.locationState.latidude,
                     venues: state.homeState.venues,
                     accessToken: state.loginState.accessCode,
                     checkedInVenue: state.checkInState.checkedInVenue,
                     dispatch: dispatch)
    }

    func body(props: Props) -> some View {
        Text(props.accessToken ?? "no token")
    }
}
