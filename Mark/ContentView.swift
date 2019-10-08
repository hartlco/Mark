//
//  ContentView.swift
//  Mark
//
//  Created by martin on 01.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import SwiftUI
import SwiftUIFlux

struct ContentView: View {
    @EnvironmentObject var store: Store<AppState>

    var body: some View {
        VStack {
            Text(store.state.homeState.text)
            Button(action: {
                self.store.dispatch(action: HomeActions.ChangeAction(newText: "test"))
            }) {
                Text("Test")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
