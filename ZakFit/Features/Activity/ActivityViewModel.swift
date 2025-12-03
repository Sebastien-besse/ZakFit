//
//  ActivityViewModel.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
class ActivityViewModel {
    // MARK: - Existant
    var exercises: [ExerciseDTO] = []
    var selectedExerciseID: UUID?
    var calories: Int?
    var date: Date = Date()
    var errorMessage: String?
    var isLoading = false
    var token: String
    
    // MARK: - Slider haltère
    var dumbbellMaxWidth: CGFloat = 380
    var sliderWidth: CGFloat = 0
    var lastDragValue: CGFloat = 0
    var sliderProgress: CGFloat = 0 // de 0 à 1
    
    var duration: Int {
        get { Int(sliderProgress * 299) + 1 } // de 1 à 300
        set {
            sliderProgress = CGFloat(newValue - 1) / 299
            sliderWidth = sliderProgress * dumbbellMaxWidth
            lastDragValue = sliderWidth
        }
    }
    
    // MARK: - Flame Calories Slider
    var flameMaxHeight: CGFloat { 180 }      // hauteur totale de la flamme
    var flameFillHeight: CGFloat = 60        // hauteur remplie actuelle
    var flameLastDrag: CGFloat = 0           // sauvegarde fin drag
    var flameProgress: CGFloat = 0           // entre 0 et 1
    
    var caloriesBurned: Int {
        get { Int(flameProgress * 1000) }    // exemple : max 1000 calories
        set {
            let p = CGFloat(newValue) / 1000
            flameProgress = min(max(p, 0), 1)
            flameFillHeight = flameProgress * flameMaxHeight
            flameLastDrag = flameFillHeight
        }
    }

    // MARK: - Filtrage
    enum ExerciseFilter: String, CaseIterable {
        case musculation = "Musculation"
        case cardio = "Cardio"
        case bienEtre = "Bien-être"
    }
    
    var selectedFilter: ExerciseFilter = .musculation

    var filteredExercises: [ExerciseDTO] {
        switch selectedFilter {
        case .musculation: return exercises.filter { $0.type == "Musculation" }
        case .cardio: return exercises.filter { $0.type == "Cardio" }
        case .bienEtre: return exercises.filter { $0.type == "Bien-être" }
        }
    }
    
    func imageForExercise(_ ex: ExerciseDTO) -> String {
        switch ex.name {
        case "Pump": return "NailPump"
        case "Haltéro": return "NailHaltero"
        case "CrossFit": return "NailCrossfit"
        case "Street Workout": return "NailStreetWorkout"
        case "Course à pied": return "NailRun"
        case "Marche": return "NailRun"
        case "Hyrox": return "NailCrossfit"
        case "Yoga": return "NailYoga"
        case "Méditation": return "NailYoga"
        case "Stretching": return "NailYoga"
        default: return "NailDefault"
        }
    }

    // MARK: - Init
    init(token: String) {
        self.token = token
        self.duration = 30
    }
    
    init(token: String, exercises: [ExerciseDTO] = []) {
        self.token = token
        self.exercises = exercises
        self.selectedExerciseID = exercises.first?.id
        self.duration = 30
    }

    // MARK: - Network
    func fetchExercises() async {
        do {
            exercises = try await APIService.shared.getToken(endpoint: "/activity/exercises", token: token, as: [ExerciseDTO].self)
            selectedExerciseID = filteredExercises.first?.id
        } catch {
            errorMessage = "Impossible de récupérer les exercices"
        }
    }


    func createActivity() async -> ActivityDTO? {
        guard let exerciseID = selectedExerciseID else {
            errorMessage = "Veuillez sélectionner un exercice"
            return nil
        }

        // Formatter compatible Vapor
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
        let dateString = formatter.string(from: date)

        let dto = ActivityCreateDTO(
            exerciseID: exerciseID,
            duration: duration,
            caloriesBurned: calories,
            date: dateString
        )

        isLoading = true
        defer { isLoading = false }

        do {
            // Envoie vers le backend
            let response = try await ActivityService.shared.createActivity(dto: dto, token: token)

            // Transformer la réponse backend en ActivityDTO côté front
            let ex = exercises.first(where: { $0.id == exerciseID })
            return ActivityDTO(
                id: response.id,
                exerciseName: ex?.name,
                activityType: ex?.type,
                duration: response.duration,
                calories: response.calories,
                date: response.date,
                motivationMessage: ex?.motivationMessage
            )

        } catch {
            errorMessage = "Impossible de créer l'activité"
            return nil
        }
    }
    }

