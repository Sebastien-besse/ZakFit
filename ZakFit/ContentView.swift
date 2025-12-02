//
//  ContentView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 28/11/2025.
//

import SwiftUI

struct ContentView: View {

    @Environment(AuthViewModel.self) var authVM
    @State private var profileVM = ProfileViewModel()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {

            Group {
                if authVM.isAuth {
                    HomeView(path: $path)
                        .environment(profileVM)
                } else {
                    AuthView()
                }
            }

            .navigationDestination(for: AppRoutes.self) { route in
                switch route {
                case .profile:
                    ProfilView()
                        .environment(profileVM) // ← récupérer le même
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthViewModel())
}


