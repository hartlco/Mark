//
//  ContentView.swift
//  Mark
//
//  Created by martin on 01.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUI
import SwiftUIFlux
import flux
import Models

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
        NavigationView {
            VStack {
                List(props.venues) { venue in
                    HStack(spacing: 8.0) {
                        VStack(alignment: .leading) {
                            Text(venue.name)
                                .font(.headline)
                            venue.location.address.map {
                                Text($0)
                                    .font(.subheadline)
                            }
                        }
                        Spacer()
                        CheckInButton(venue: venue,
                                      checkedIn: props.checkedInVenue?.id == venue.id,
                                      action: {
                                        props.dispatch(CheckInAction.CheckIn(venue: venue,
                                                                             accessCode: props.accessToken))
                        })
                    }
                }
            }
            .navigationBarItems(leading: reloadButton(props: props), trailing: navigationButton)
            .navigationBarTitle("Mark - \(props.latitude) - \(props.longitude)")
        }
    }

    private var navigationButton: some View {
        NavigationLink(destination: SettingsView()) {
            Text("Settings")
        }
    }

    private func reloadButton(props: Props) -> some View {
        Button(action: {
            props.dispatch(HomeActions.FetchVenues(latidude: props.latitude,
                                                                longitude: props.longitude))
        }) {
            Text("Load")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(sampleStore)
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
        }
        .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
        .background(color)
        .cornerRadius(8)
        .shadow(color: Color(.sRGB, white: 0, opacity: 0.2),
                radius: 5,
                x: 0,
                y: 3)
    }

    private var text: String {
        return checkedIn ? "Checked In" : "Check In"
    }

    private var color: Color {
        return checkedIn ? .blue : .orange
    }
}
