//
//  SceneDelegate.swift
//  Mark
//
//  Created by martin on 01.10.19.
//  Copyright © 2019 Martin Hartl. All rights reserved.
//

import UIKit
import SwiftUI
import SwiftUIFlux
import flux
import Models
import Services

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    let store = Store<AppState>(reducer: appReducer,
                                middleware: [loggingMiddleware, lastCheckinMiddleware, TokenMiddleware().storeTokenMiddleware],
                                state: AppState(homeState: HomeState(venues: []),
                                                locationState: LocationState(longitude: "0", latidude: "0"),
                                                loginState: LoginState(accessCode: nil),
                                                checkInState: CheckinState(checkedInVenue: nil)))

    let updateAction = LocationAction.UpdateLocation(locationService: .shared)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            let view = StoreProvider(store: store) {
                    ContentView()
            }

            let hostingController = UIHostingController(rootView: view)

            window.rootViewController = hostingController
            self.window = window

            window.makeKeyAndVisible()

            store.dispatch(action: LoginAction.GetAccessCodeFromKeychain(loginServie: LoginService()))
            store.dispatch(action: updateAction)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        for urlContext in URLContexts {
            store.dispatch(action: LoginAction.ExtractAccessCode(url: urlContext.url,
                                                                 loginService: LoginService()))
        }
    }
}


#if DEBUG
let venues = [
    Venue(name: "Home", id: "1", location: Venue.Location(address: "Berlin")),
    Venue(name: "Work", id: "2", location: Venue.Location(address: "Berlin")),
    Venue(name: "Fun", id: "3", location: Venue.Location(address: "Berlin"))
]
let sampleStore = Store<AppState>(reducer: appReducer,
                                  state: AppState(homeState: HomeState(venues: venues),
                                                  locationState: LocationState(longitude: "0", latidude: "0"),
                                                  loginState: LoginState(accessCode: nil),
                                                  checkInState: CheckinState(checkedInVenue: nil)))
#endif
