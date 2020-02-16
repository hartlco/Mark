//
//  ContentView.swift
//  Mark-Watch WatchKit Extension
//
//  Created by martin on 15.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUI
import Constants
import Models
import Services_Watch
import flux_Watch
import SwiftUIFlux

struct ContentView: ConnectedView {
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
        VStack {
            HStack(alignment: .bottom) {
                Text("\(props.latitude) - \(props.longitude)")
                    .font(.caption)
                    .lineLimit(1)
                Button(action: {
                    props.dispatch(HomeActions.FetchVenues(latidude: props.latitude,
                                                           longitude: props.longitude))
                }) {
                    Text("Load")
                        .font(.caption)
                }
            }
            List(props.venues) { venue in
                CheckInButton(venue: venue,
                              checkedIn: props.checkedInVenue?.id == venue.id,
                              action: {
                                props.dispatch(CheckInAction.CheckIn(venue: venue,
                                                                     accessCode: props.accessToken))
                })
            }
        }
    }
}

struct CheckInButton: View {
    let venue: Venue
    let checkedIn: Bool
    let action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(text)
                .font(.callout)
                .foregroundColor(color)
        }
    }

    private var text: String {
        return venue.name
    }

    private var color: Color {
        return checkedIn ? .blue : .orange
    }
}
