//
//  RegisterViewModel.swift
//  ZakFit
//
//  Created by apprenant152 on 01/12/2025.
//

import Foundation
import Observation
import SwiftUI

@Observable
class RegisterViewModel {
    
    let rs = RegisterService()

    enum Step: Int, CaseIterable {
        case gender, height, weight, goal, diet, personalInfo
    }

    // MARK: - Étape actuelle
    var currentStep: Step = .gender
    var previousStep: Step = .gender
    var isGoingForward = true

    // MARK: - Données du compte
    var gender: String = ""
    var height: Int = 170
    var weight: Int = 70
    var goalSelected: String = ""
    var dietSelected: String = ""

    var firstname = ""
    var lastname = ""
    var email = ""
    var password = ""
    var dateOfBirth: Date = Date() 


    // MARK: - Listes
    var goals: [String] = ["Perte de poids", "Prise de muscle", "Remise en forme", "Renforcement"]
    var diets: [String] = ["omnivore","Carnivore", "Végan", "Végétarien"]

    // MARK: - Progression
    var progress: Double {
        Double(currentStep.rawValue + 1) / Double(Step.allCases.count)
    }

    var canGoNext: Bool {
        currentStep.rawValue < Step.allCases.count - 1
    }

    var canGoBack: Bool {
        currentStep.rawValue > 0
    }

    // MARK: - Navigation
    func next() {
        if canGoNext {
            previousStep = currentStep
            currentStep = Step(rawValue: currentStep.rawValue + 1)!
            isGoingForward = true
        }
    }

    func previous() {
        if canGoBack {
            previousStep = currentStep
            currentStep = Step(rawValue: currentStep.rawValue - 1)!
            isGoingForward = false
        }
    }

    // MARK: - Validation
    var isEmailValid: Bool {
        email.contains("@") && email.contains(".")
    }

    var isSubmitDisabled: Bool {
        currentStep == .personalInfo ? !canSubmit : false
    }

    var canSubmit: Bool {
        !firstname.isEmpty &&
        !lastname.isEmpty &&
        isEmailValid &&
        password.count >= 6
    }

    // MARK: - API Call
    func submit() async throws -> UserResponseDTO {

        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"

        let req = UserRequestDTO(
            firstname: firstname,
            lastname: lastname,
            email: email,
            password: password,
            genre: gender,
            height: height,
            weight: weight,
            objectif: goalSelected,
            diet: dietSelected,
            dateOfBirth: formatter.string(from: dateOfBirth)
        )


        return try await rs.register(req: req)
    }
}


