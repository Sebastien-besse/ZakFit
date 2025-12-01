//
//  RegisterView.swift
//  ZakFit
//
//  Created by apprenant152 on 01/12/2025.
//

import SwiftUI

struct RegisterView: View {

    @Environment(RegisterViewModel.self) var vm

    var body: some View {

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
                Text(vm.canGoNext ? "Continuer" : "Créer mon compte")
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

    // MARK: - HELPERS
    var submitColor: Color {
        vm.currentStep == .personalInfo && !vm.canSubmit ? .brownPrimary.opacity(0.4) : .brownPrimary
    }

    // MARK: - API CALL
    func createAccount() async {
        do {
            let user = try await vm.submit()
            print("Compte créé avec succès :", user)

            // TODO : route vers Onboarding terminé ou HomeScreen
            // ex: navigateToHome = true

        } catch {
            print("Erreur API :", error.localizedDescription)
            // TODO : afficher une alerte
        }
    }
}

#Preview {
    RegisterView()
        .environment(RegisterViewModel())
}

