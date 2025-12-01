//
//  GenderView.swift
//  ZakFit
//
//  Created by apprenant152 on 01/12/2025.
//

import SwiftUI

struct GenderView: View {
    @Environment(RegisterViewModel.self) var vm

    var body: some View {
        VStack(spacing: 30) {
          
                Text("Parle moi de toi ?")
                    .font(.custom("Futura Condensed ExtraBold", size: 40))
                    .tracking(-3)
                    .foregroundStyle(.brownPrimary)
                Text("Pour vous offrir une meilleure expérience et un meilleur résultat, nous avons besoin de connaître ton genre.")
                    .font(.custom("Futura", size: 14))
                    .foregroundStyle(.brownPrimary.opacity(0.4))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            
            
           
            Spacer()
            VStack(spacing: 30) {
                genderButton("Homme", "GenderMen")
                genderButton("Femme", "GenderWomen")
            }
            Spacer()
        }
    }

    func genderButton(_ gender: String, _ iconName: String) -> some View {
        Button {
            vm.gender = gender
        } label: {
            ZStack {
                Circle()
                    .fill(vm.gender == gender ? Color.brownPrimary : Color.brownPrimary.opacity(0.2))
                    .frame(width: 140, height: 140)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                
                Image(iconName) // SF Symbol ou ton image perso
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(vm.gender == gender ? .background : .brownPrimary)
            }
        }
        .buttonStyle(.plain)
        
    }

}


#Preview {
    GenderView()
        .environment(RegisterViewModel())
}
