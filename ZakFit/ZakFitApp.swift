//
//  ZakFitApp.swift
//  ZakFit
//
//  Created by Sebastien Besse on 28/11/2025.
//

import SwiftUI

@main
struct ZakFitApp: App {
    @State var authVM = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authVM)
        }
    }
}
