//
//  HomeView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 29/11/2025.
//

import SwiftUI

struct HomeView: View {
    @Binding var path: NavigationPath
    @Environment(ProfileViewModel.self) var profileVM
    @Environment(AuthViewModel.self) var authVM
    @State private var showObjectifActivity = false
    @State private var showObjectifCalories = false
    var body: some View {
        VStack(spacing: 12) {

            // HEADER
            HStack(spacing: 46){
                Text("Holà Poulet !")
                    .font(.custom("Futura Condensed ExtraBold", size: 40))
                    .tracking(-2)
                    .foregroundStyle(.brownPrimary)
                
                Button {
                    path.append(AppRoutes.profile)
                    if let token = authVM.token {
                        Task { await profileVM.loadProfile(token: token) }
                    }
                } label: {
                    Circle()
                        .fill(.pinkPrimary)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image("IconeProfil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.brownPrimary)
                        }
                }
            }
            .padding(.top)

            // TEXTE + CELLS
            VStack(alignment: .leading, spacing: 12){
                Text("Allez bouge toi un peu!")
                    .font(.custom("Futura Condensed ExtraBold", size: 20))
                    .tracking(-1)
                    .foregroundStyle(.brownPrimary)
                
                ActivityDayCell(exercice: "Pump", type: "Musculation", time: 90)
                ObjectifHebdoCell(succes: 45)
            }
            .padding(.top, -14)
           
            VStack {
                Text("30% de ton objectif quotidien")
                    .font(.custom("Futura Bold", size: 12))
                Image("NailObjectifDay")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 250)
                    .padding(.leading, 30)
            }
            .padding(.vertical)
            Text("Tes objectifs")
                .font(.custom("Futura Medium", size: 12))
            HStack(spacing: 20) {
                VStack {
                    Button {
                        showObjectifActivity = true
                    } label: {
                        Circle()
                            .fill(.brownPrimary)
                            .frame(width: 60, height: 60)
                            .overlay {
                                Image("HeartObjectif")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                    }
                    Text("Activité")
                        .font(.custom("Futura Medium", size: 12))
                }

                VStack {
                    Button { showObjectifCalories = true }
                    label: {
                        Circle()
                            .fill(.brownPrimary)
                            .frame(width: 60, height: 60)
                            .overlay {
                                Image("FlameObjectif")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                    }
                    Text("Calories")
                        .font(.custom("Futura Medium", size: 12))
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .fullScreenCover(isPresented: $showObjectifActivity) {
            ObjectifActivityView(frequence: 3, onClose: {
                showObjectifActivity = false
            })
        }
        .fullScreenCover(isPresented: $showObjectifCalories) {
            ObjectifCalorieView(frequence: 3, onClose: {
                showObjectifCalories = false
            })
        }
        .background(Color.background)
    }
}

// Preview
#Preview {
    @Previewable @State var path = NavigationPath()
    let profileVM = ProfileViewModel()
    let authVM = AuthViewModel()
    
    HomeView(path: $path)
        .environment(authVM)
        .environment(profileVM)
}
