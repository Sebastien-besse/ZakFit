//
//  ActivityDTO.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import Foundation

struct ExerciseDTO: Codable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let type: String
    let defaultCaloriesPerMin: Int
}


struct ActivityDTO: Codable, Identifiable {
    let id: UUID
    let exerciseID: UUID
    let duration: Int
    let caloriesBurned: Int
    let date: Date
    var exercise: ExerciseDTO? // optionnel pour stocker le nom/type
}

// DTO pour créer l’activité
struct ActivityCreateDTO: Codable {
    let exerciseID: UUID
    let duration: Int
    let caloriesBurned: Int?
    let date: Date?
}

// DTO pour mettre à jour l’activité
struct ActivityUpdateDTO: Codable {
    let exerciseID: UUID?
    let duration: Int?
    let caloriesBurned: Int?
    let date: Date?
}
