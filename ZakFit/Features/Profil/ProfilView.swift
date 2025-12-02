//
//  ProfilView.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//
import SwiftUI

struct ProfilView: View {

    @Environment(AuthViewModel.self) var authVM
    @Environment(ProfileViewModel.self) var vm
    

    var body: some View {
        VStack {
        
            
            
            if vm.isLoading {
                ProgressView("Chargement…")
                    .padding()
            } else if let user = vm.user {

                ScrollView {
                    VStack(spacing: 25) {
                        HStack{
                            Image("NailProfil")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 143, height: 135)
                            Text(vm.user?.gender == "Homme" ? "Profil du champion" : "Profil de championne")
                                .font(.custom("Futura Condensed ExtraBold", size: 44))
                                .tracking(-2)
                                .foregroundStyle(.brownPrimary)
                        }
                        HStack(spacing: 20){
                            ProfileTextFieldCell(
                                width: 160, text: Binding(
                                                    get: { vm.user?.lastname ?? "" },
                                                    set: { vm.user?.lastname = $0 }
                                                 ))

                            ProfileTextFieldCell(
                                width: 130, text: Binding(
                                                    get: { vm.user?.firstname ?? "" },
                                                    set: { vm.user?.firstname = $0 }
                                                 ))
                        }
                        

                        ProfileTextFieldCell(
                            width: 310, text: Binding(
                                                get: { vm.user?.email ?? "" },
                                                set: { vm.user?.email = $0 }
                                             ))

                        HStack(spacing: 20){
                            CardCell(
                                image: "Rocket", text: Binding(
                                                    get: { vm.user?.objectifHealth ?? "" },
                                                    set: { vm.user?.objectifHealth = $0 }
                                                 ))

                            CardCell(
                                image: "IconeProfilDiet", text: Binding(
                                                    get: { vm.user?.diet ?? "" },
                                                    set: { vm.user?.diet = $0 }
                                                 ))
                        }
                        
                        HStack(spacing: 20){
                            CardCell(
                                image: "IconeProfilHeight",
                                text: Binding(
                                    get: {
                                        if let height = vm.user?.height {
                                            return "\(height) cm"
                                        }
                                        return ""
                                    },
                                    set: { newValue in
                                        // On récupère juste les chiffres de la chaîne
                                        let digits = newValue.filter { $0.isNumber }
                                        if let intValue = Int(digits) {
                                            vm.user?.height = intValue
                                        }
                                    }
                                )
                            )


                            CardCell(
                                image: "IconeProfilWeight",
                                text: Binding(
                                    get: {
                                        if let weight = vm.user?.weight {
                                            return "\(weight) cm"
                                        }
                                        return ""
                                    },
                                    set: { newValue in
                                        // On récupère juste les chiffres de la chaîne
                                        let digits = newValue.filter { $0.isNumber }
                                        if let intValue = Int(digits) {
                                            vm.user?.height = intValue
                                        }
                                    }
                                )
                            )

                        }
                      

                        Button {
                            Task {
                                if let token = authVM.token {
                                    await vm.updateProfile(token: token)
                                }
                            }
                        } label: {
                            Text("Enregistrer")
                                .font(.custom("Futura Condensed ExtraBold", size: 22))
                                .foregroundColor(Color.background)
                                .padding()
                                .frame(width: 300)
                                .background(Color.brownPrimary)
                                .cornerRadius(15)
                                .shadow(radius: 4)
                        }
                        .padding(.top, 10)

                        if let error = vm.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .padding()
                        }

                        Button(role: .destructive) {
                            authVM.logout()
                        } label: {
                            Text("Se déconnecter")
                                .font(.custom("Futura Condensed ExtraBold", size: 22))
                                .foregroundColor(Color.background)
                                .padding()
                                .frame(width: 300)
                                .background(Color.pinkPrimary)
                                .cornerRadius(15)
                                .shadow(radius: 4)
                        }
                    }
                    .padding()
                }

            } else {
                Text("Aucune donnée utilisateur")
                    .foregroundStyle(.gray)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .onAppear {
            Task {
                if let token = authVM.token {
                    await vm.loadProfile(token: token)
                }
            }
        }
    }
}

#Preview {
    ProfilView()
        .environment(AuthViewModel())
        .environment(ProfileViewModel())
}


