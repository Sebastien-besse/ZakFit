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
    @State private var path = NavigationPath()         // navigation interne
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if authVM.isAuth {
                    MainTabView(profileVM: profileVM, pathFromContent: $path)
                        .environment(profileVM) // injecte le VM partout dans MainTabView
                } else {
                    AuthView()
                }
            }
            .navigationDestination(for: AppRoutes.self) { route in
                switch route {
                case .profile:
                    ProfilView()
                        .environment(profileVM)
                }
            }
        }
    }
}
// Preview simplifiée
#Preview {
    let authVM = AuthViewModel()
    ContentView()
        .environment(authVM)
        .environment(ProfileViewModel())
}

