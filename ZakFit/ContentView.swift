//
//  ContentView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 28/11/2025.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AuthViewModel.self) var authVM

    var body: some View {
        Group {
            if authVM.isAuth {
                HomeView()
            } else {
                AuthView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthViewModel())
}
