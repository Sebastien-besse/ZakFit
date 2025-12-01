//
//  GoalView.swift
//  ZakFit
//
//  Created by apprenant152 on 01/12/2025.
//

import SwiftUI

struct GoalView: View {
    @Environment(RegisterViewModel.self) var vm

    var body: some View {
        @Bindable var vm = vm
        VStack(spacing: 20) {
            Text("Ton objectif ?")
                .font(.custom("Futura Condensed ExtraBold", size: 40))
                .tracking(-3)
                .foregroundStyle(.brownPrimary)
            
            Text("Choisi ton objectif. Ne t'inquiéte pas, tu pourras toujours le modifier plus tard")
                .font(.custom("Futura", size: 14))
                .foregroundStyle(.brownPrimary.opacity(0.4))
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            ForEach(vm.goals, id: \.self) { goal in
                Button {
                    vm.goalSelected = goal
                } label: {
                    Text(goal)
                        .font(.custom("Futura Condensed ExtraBold", size: 30))
                        .tracking(-2)
                        .foregroundStyle(vm.goalSelected == goal ? .brownPrimary : .background)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(vm.goalSelected == goal ? .yellowPrimary : .brownPrimary)
                        .clipShape(.rect(cornerRadius: 40))
                }
            }
            Spacer()
        }
        .padding()
    }
}


#Preview {
    GoalView()
        .environment(RegisterViewModel())
}
