//
//  ActivityDTO.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import Foundation

// MARK: - Exercise
struct ExerciseDTO: Codable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let type: String
    let defaultCaloriesPerMin: Int
    let motivationMessage: String
}

// MARK: - Activity Returned by Backend
struct ActivityDTO: Codable, Identifiable {
    let id: UUID?
    let exerciseName: String?
    let activityType: String?
    let duration: Int
    let calories: Int
    let date: Date
    let motivationMessage: String?
}

// MARK: - Activity Create (Front → Backend)
/// IMPORTANT : `date` doit être au format **String ISO8601**, sinon Vapor rejette.
struct ActivityCreateDTO: Codable {
    let exerciseID: UUID
    let duration: Int
    let caloriesBurned: Int?
    let date: String   // ⚠️ String ISO8601
}

// MARK: - Activity Update
/// Même règle : `date` doit être une String ISO8601.
struct ActivityUpdateDTO: Codable {
    let exerciseID: UUID?
    let duration: Int?
    let caloriesBurned: Int?
    let date: String?
}


