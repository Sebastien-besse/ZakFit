//
//  DietView.swift
//  ZakFit
//
//  Created by apprenant152 on 01/12/2025.
//

import SwiftUI

struct DietView: View {
    @Environment(RegisterViewModel.self) var vm

    var body: some View {
        @Bindable var vm = vm

            VStack(spacing: 20) {
                Text("Ton régime ?")
                    .font(.custom("Futura Condensed ExtraBold", size: 40))
                    .tracking(-3)
                    .foregroundStyle(.brownPrimary)
                Spacer()
                ForEach(vm.diets, id: \.self) { diet in
                    Button {
                        vm.dietSelected = diet
                    } label: {
                        Text(diet)
                            .font(.custom("Futura Condensed ExtraBold", size: 30))
                            .tracking(-2)
                            .foregroundStyle(vm.dietSelected == diet ? .brownPrimary : .background)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(vm.dietSelected == diet ? .yellowPrimary : .brownPrimary)
                            .clipShape(.rect(cornerRadius: 40))
                    }
                }
                Spacer()
            }
            .padding()
        }
    }

#Preview {
    DietView()
        .environment(RegisterViewModel())
}
