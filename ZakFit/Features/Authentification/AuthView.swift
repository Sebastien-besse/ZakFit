//
//  AuthView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 28/11/2025.
//

import SwiftUI
 
struct AuthView: View {
    @Environment(AuthViewModel.self) @Bindable var authVM
    var body: some View {
        VStack(spacing: 100){
            Text("ICI POUR ÊTRE MEILLIEUR !")
                .font(.custom("Futura Condensed ExtraBold", size: 64)).tracking(-5)
                .foregroundStyle(.brownPrimary)
                .overlay{
                    Image("NailAuth")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 224)
                        .padding(.trailing, 240)
                }
                .padding(.top, 50)
            VStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.background)
                    .frame(width: 300, height: 50)
                    .overlay(alignment: .center) {
                        TextField("Email", text: $authVM.email)
                                .font(.custom("Futura Condensed ExtraBold", size: 20)).tracking(-1)
                                .foregroundStyle(.brownPrimary)
                            
                        
                        .padding()
                    }
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 4)
                HStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.background)
                        .frame(width: 240, height: 50)
                        .overlay(alignment: .center) {
                            TextField("Mot de passe", text: $authVM.password)
                                    .font(.custom("Futura Condensed ExtraBold", size: 20)).tracking(-1)
                                    .foregroundStyle(.brownPrimary)
                                
                            
                            .padding()
                        }
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 4)
                    Button {
                        Task {
                            await authVM.login()
                        }
                    }
                    label: {
                        Image(systemName: "arrow.forward")
                            .font(.system(size: 18, weight: .black))
                            .foregroundStyle(.brownPrimary)
                        
                    }
                    .frame(width: 50, height: 50)
                    .background {
                        Circle()
                            .fill(.pinkPrimary)
                    }
                }
            }
            
            
            Button {
                print("commencer")
            } label: {
                HStack{
                    Text("Commencer")
                        .font(.custom("Futura Condensed ExtraBold", size: 20)).tracking(-1)
                        .foregroundStyle(Color.background)
                        .bold()
                        .frame(width: 130, height:32)
                    
                }
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.brownPrimary)
                        .frame(width: 200, height: 44)
                    
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}


#Preview {
    AuthView()
        .environment(AuthViewModel())
}
