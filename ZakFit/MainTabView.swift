//
//  MainTabView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 03/12/2025.
//

import SwiftUI
import CardCarousel

struct MainTabView: View {
    @Environment(AuthViewModel.self) var authVM
    @State private var activityVM = ActivityViewModel(token: "") // token mis à jour plus tard
    @State private var path = NavigationPath()                   // pour HomeView interne
    var profileVM: ProfileViewModel
    @Binding var pathFromContent: NavigationPath                 // binding depuis ContentView

    var body: some View {
        TabView {
            HomeView(path: $pathFromContent)
                .environment(profileVM)
                .tabItem {
                    Label("Temple", systemImage: "house.fill")
                }

            ActivityView(vm: activityVM)
                .onAppear {
                    if let token = authVM.token {
                        activityVM.token = token
                        Task { await activityVM.fetchExercises() }
                    }
                }
                .tabItem {
                    Label("Activité", systemImage:"dumbbell.fill")
                }
            
            AddMealView(foodname: "", quantity: 0)
                .tabItem {
                    Label("Repas", systemImage: "fork.knife")
                }
            
            // ——— Ajout de l'onglet Historique
            HistoryView()
                .tabItem {
                    Label("Historique", systemImage: "clock.fill")
                }
        }
        .tint(.pinkPrimary)
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    let profileVM = ProfileViewModel()
    let authVM = AuthViewModel()
    
    MainTabView(profileVM: profileVM, pathFromContent: $path)
        .environment(authVM)
}

