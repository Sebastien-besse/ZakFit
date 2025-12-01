//
//  PersonalInfoView.swift
//  ZakFit
//
//  Created by apprenant152 on 01/12/2025.
//

import SwiftUI

struct PersonalInfoView: View {
    @Environment(RegisterViewModel.self) var vm

    var body: some View {
        @Bindable var vm = vm

        VStack(spacing: 20) {
            Text("Ton profil ?")
                .font(.custom("Futura Condensed ExtraBold", size: 40))
                .tracking(-3)
                .foregroundStyle(.brownPrimary)
            Text("Dernière ligne droite sur ton identité. Tu connais la data ça paye")
                .font(.custom("Futura", size: 14))
                .foregroundStyle(.brownPrimary.opacity(0.4))
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Spacer()
            HStack{
                TextFieldFormCell(userData: $vm.lastname, label: "Prénom", width: 180, height: 50)
                TextFieldFormCell(userData: $vm.firstname, label: "Nom", width: 150, height: 50)
            }
  
                DatePicker(
                    "Date de naissance",
                    selection: $vm.dateOfBirth,
                    displayedComponents: .date
                )
                .font(.custom("Futura Condensed ExtraBold", size: 20))
                .tracking(-1)
                .foregroundStyle(.pinkPrimary)
                .datePickerStyle(.compact)
                .frame(maxWidth: .infinity)
            

            TextFieldFormCell(userData: $vm.email, label: "Email", width: 340, height: 50)
                .keyboardType(.emailAddress)
                .overlay(alignment: .trailing) {
                    if !vm.isEmailValid && !vm.email.isEmpty {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.red)
                    }
                }

            SecureFieldFormCell(password: $vm.password, width: 340, height: 50, isConfirmPassword: false)
            SecureFieldFormCell(password: $vm.password, width: 340, height: 50, isConfirmPassword: true)
            
            Spacer()
               
        }
        .padding()
    }
}


#Preview {
    PersonalInfoView()
        .environment(RegisterViewModel())
}
