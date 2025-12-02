//
//  HomeView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 29/11/2025.
//

import SwiftUI

struct HomeView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            Text("Home View")
                .font(.title)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    path.append(AppRoutes.profile)
                } label: {
                    Circle()
                        .fill(.pinkPrimary)
                        .frame(width: 44, height: 44)
                        .overlay{
                            Image("IconeProfil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.brownPrimary)
                        }
                    
                }
            }
        }
    }
}

#Preview {
    HomeView(path: .constant(NavigationPath()))
}
