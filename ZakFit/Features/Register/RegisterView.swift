//
//  RegisterView.swift
//  ZakFit
//
//  Created by apprenant152 on 01/12/2025.
//

import SwiftUI
import Observation

struct RegisterView: View {
    
    @Environment(AuthViewModel.self) var auth       // même instance que ContentView
    @Environment(RegisterViewModel.self) var vm
    @Environment(\.dismiss) private var dismiss    // pour fermer RegisterView automatiquement

    var body: some View {
        NavigationStack {
            VStack {
                
                // MARK: - Progress bar
                progressHeader
                
                // MARK: - Step Form
                ZStack {
                    switch vm.currentStep {
                    case .gender: GenderView()
                    case .height: HeightView()
                    case .weight: WeightView()
                    case .goal: GoalView()
                    case .diet: DietView()
                    case .personalInfo: PersonalInfoView()
                    }
                }
                .transition(.asymmetric(
                    insertion: .move(edge: vm.isGoingForward ? .trailing : .leading),
                    removal: .move(edge: vm.isGoingForward ? .leading : .trailing)
                ))
                .id(vm.currentStep)
                .animation(.easeInOut, value: vm.currentStep)
                
                Spacer()
                
                bottomButtons
                    .padding(.horizontal)
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
    }
}

// MARK: - Progress bar
extension RegisterView {
    var progressHeader: some View {
        GeometryReader { geo in
            let totalWidth = geo.size.width * 0.9
            let progressWidth = totalWidth * vm.progress

            ZStack(alignment: .leading) {

                Capsule()
                    .fill(.gray.opacity(0.2))
                    .frame(height: 12)

                Capsule()
                    .fill(.pinkPrimary)
                    .frame(width: progressWidth, height: 12)
                    .animation(.easeInOut, value: vm.progress)

                Image("NailRegister")
                    .resizable()
                    .frame(width: 50, height: 40)
                    .offset(
                        x: progressWidth - 20,
                        y: -12
                    )
                    .animation(.easeInOut, value: vm.progress)
            }
            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
        }
        .frame(height: 40)
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

// MARK: - Bottom buttons
extension RegisterView {
    var bottomButtons: some View {
        HStack(spacing: 15) {

            // MARK: - PREVIOUS BUTTON
            Button {
                vm.previous()
            } label: {
                Text("Précédent")
                    .font(.custom("Futura Condensed ExtraBold", size: 24))
                    .foregroundStyle(.brownPrimary)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.brownPrimary.opacity(0.1))
                    .clipShape(.rect(cornerRadius: 10))
            }
            .disabled(!vm.canGoBack)

            // MARK: - CONTINUE OR SUBMIT
            Button {
                if vm.canGoNext {
                    vm.next()
                } else {
                    if vm.canSubmit {
                        Task { await createAccount() }
                    }
                }
            } label: {
                Text(vm.canGoNext ? "Continuer" : "Let's go!")
                    .font(.custom("Futura Condensed ExtraBold", size: 24))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(submitColor)
                    .foregroundStyle(Color.background)
                    .clipShape(.rect(cornerRadius: 10))
            }
            .disabled(vm.isSubmitDisabled)
        }
    }

    var submitColor: Color {
        vm.currentStep == .personalInfo && !vm.canSubmit ? .brownPrimary.opacity(0.4) : .brownPrimary
    }
}

// MARK: - API CALL + Auto-login + Navigation
extension RegisterView {
    func createAccount() async {
        do {
            // 1️⃣ Création du compte
            let user = try await vm.submit()
            print("Compte créé avec succès :", user)

            // 2️⃣ Connexion automatique
            auth.email = vm.email
            auth.password = vm.password
            await auth.login()
            print("TOKEN =", auth.token ?? "aucun token")
            print("auth.isAuth =", auth.isAuth)

            // 3️⃣ Fermer RegisterView pour revenir à ContentView
            if auth.isAuth {
                dismiss()
            }

        } catch {
            print("Erreur API :", error.localizedDescription)
            // tu peux afficher un alert ici
        }
    }
}

#Preview {
    RegisterView()
        .environment(RegisterViewModel())
        .environment(AuthViewModel())
}

