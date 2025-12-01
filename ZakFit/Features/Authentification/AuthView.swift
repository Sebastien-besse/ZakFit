//
//  AuthView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 28/11/2025.
//

import SwiftUI

struct AuthView: View {
    
    @Environment(AuthViewModel.self) private var authVM

    var body: some View {
        @Bindable var authVM = authVM
        
        VStack(spacing: 100) {
            Text("ICI POUR ÊTRE MEILLIEUR !")
                .font(.custom("Futura Condensed ExtraBold", size: 64))
                .tracking(-5)
                .foregroundStyle(.brownPrimary)
                .overlay {
                    Image("NailAuth")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 224)
                        .padding(.trailing, 240)
                }
                .padding(.top, 50)

            VStack(alignment: .leading) {

                TextFieldFormCell(userData: $authVM.email, label: "Email", width: 300, height: 60)

                HStack {
                    SecureFieldFormCell(password: $authVM.password, width: 240, height: 60, isConfirmPassword: false)

                    Button {
                        Task { await authVM.login() }
                    } label: {
                        Image(systemName: "arrow.forward")
                            .font(.system(size: 24, weight: .black))
                            .foregroundStyle(.brownPrimary)
                    }
                    .frame(width: 60, height: 60)
                    .background(Circle().fill(.pinkPrimary))
                }
                
                // Affichage des erreurs
                if let errorMessage = authVM.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .font(.caption)
                        .padding(.top, 8)
                }
            }

            Button("Commencer") {
                print("commencer")
            }
            .frame(width: 200, height: 44)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.brownPrimary)
            )
            .font(.custom("Futura Condensed ExtraBold", size: 20))
            .foregroundStyle(.white)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        
//        .navigationDestination(isPresented: $navigateToUserForm) {
//            UserFormView(userVM: userVM)
//        }
    }
}

#Preview {
    AuthView()
        .environment(AuthViewModel())
}
