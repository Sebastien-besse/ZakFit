//
//  ActivityModel.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import Foundation


// MARK: - Modèles
struct Exercise: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let defaultCaloriesPerMin: Int
    let motivationMessage: String
    let imageName: String
}

struct Activity: Identifiable {
    let id = UUID()
    let exercise: Exercise
    let duration: Int // en minutes
    let caloriesBurned: Int
    let day: String
    let month: String
    let year: String
}

