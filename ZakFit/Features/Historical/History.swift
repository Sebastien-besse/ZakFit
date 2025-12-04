//
//  History.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import Foundation

enum HistoryFilter: String, CaseIterable {
    case activities = "Activités"
    case meals = "Repas"
    case mixed = "Mix"
}
enum HistoryPeriod: String, CaseIterable {
    case week = "Semaine"
    case month = "Mois"
}
struct HistoryMonth{
    let month: String
    let trainingNumber: Int
    let carbsFire: Int
    let carbsEnergy: Int
    let mealNumber: Int
}


// MARK: - Model simplifié pour l'historique d'un jour
struct MealHistory: Identifiable {
    let id = UUID()
    let day: String
    let month: String
    let year: String
    let meals: [Meal]
}

struct ActivityHistoryDay: Identifiable {
    let id = UUID()
    let day: String
    let month: String
    let year: String
    let activities: [Activity]
}

enum DayEntry: Identifiable {
    case meal(Meal)
    case activity(Activity)

    var id: UUID {
        switch self {
        case .meal(let m): return m.id
        case .activity(let a): return a.id
        }
    }
}

struct DayHistory: Identifiable {
    let id = UUID()
    let day: String
    let month: String
    let year: String
    let meals: [Meal]
    let activities: [Activity]

    var combined: [DayEntry] {
        // 🔥 ORDERING RULE HERE
        // repas PUIS activités
        meals.map { .meal($0) } + activities.map { .activity($0) }
    }
}
