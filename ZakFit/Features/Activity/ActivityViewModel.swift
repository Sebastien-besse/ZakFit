//
//  ActivityViewModel.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import Foundation
import Observation

@MainActor
@Observable
class ActivityViewModel {
    var exercises: [ExerciseDTO] = []
    var selectedExerciseID: UUID?
    var duration: Int = 30
    var date: Date = Date()
    var calories: Int?
    var errorMessage: String?
    var isLoading = false

    var token: String
    
    enum ExerciseFilter: String, CaseIterable {
        case all = "Tous"
        case musculation = "Musculation"
        case cardio = "Cardio"
        case bienEtre = "Bien-être"
    }


    init(token: String) {
        self.token = token
    }

    func fetchExercises() async {
        do {
            exercises = try await APIService.shared.getToken(endpoint: "/exercises", token: token, as: [ExerciseDTO].self)
            selectedExerciseID = exercises.first?.id
        } catch {
            errorMessage = "Impossible de récupérer les exercices"
        }
    }

    func createActivity() async -> ActivityDTO? {
        guard let exerciseID = selectedExerciseID else {
            errorMessage = "Veuillez sélectionner un exercice"
            return nil
        }

        let dto = ActivityCreateDTO(exerciseID: exerciseID,
                                    duration: duration,
                                    caloriesBurned: calories,
                                    date: date)
        isLoading = true
        defer { isLoading = false }

        do {
            return try await ActivityService.shared.createActivity(dto: dto, token: token)
        } catch {
            errorMessage = "Impossible de créer l'activité"
            return nil
        }
    }
}
