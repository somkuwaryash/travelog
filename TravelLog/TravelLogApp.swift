//
//  TravelLogApp.swift
//  TravelLog
//
//  Created by Yash Somkuwar on 26/08/23.
//

import SwiftUI

@main
struct TravelLogApp: App {
    // Shared view model
    @StateObject var viewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            if !viewModel.didShowLaunchScreen {
                LaunchView().environmentObject(viewModel)
            } else if !viewModel.isLoggedIn {
                LoginView().environmentObject(viewModel)
            } else {
                HomeView().environmentObject(viewModel)
            }
        }
    }
}

