//
//  HistoryViewModel.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import Foundation
import Observation

@Observable
final class HistoryViewModel{
    
    var activities: [Activity] = fakeActivities
    var months: [HistoryMonth] = [
        HistoryMonth(month: "Janvier", trainingNumber: 1, carbsFire: 2200, carbsEnergy: 2400, mealNumber: 5),
        HistoryMonth(month: "Février", trainingNumber: 2, carbsFire: 2600, carbsEnergy: 2800, mealNumber: 5),
        HistoryMonth(month: "Mars", trainingNumber: 1, carbsFire: 2200, carbsEnergy: 2200, mealNumber: 5),
        HistoryMonth(month: "Avril", trainingNumber: 1, carbsFire: 2000, carbsEnergy: 2100, mealNumber: 4),
        HistoryMonth(month: "Mai", trainingNumber: 1, carbsFire: 2200, carbsEnergy: 2300, mealNumber: 5),
        HistoryMonth(month: "Juin", trainingNumber: 2, carbsFire: 2000, carbsEnergy: 2100, mealNumber: 5),
        HistoryMonth(month: "Juillet", trainingNumber: 2, carbsFire: 2200, carbsEnergy: 2300, mealNumber: 5),
        HistoryMonth(month: "Août", trainingNumber: 1, carbsFire: 2200, carbsEnergy: 2300, mealNumber: 6),
        HistoryMonth(month: "Septembre", trainingNumber: 2, carbsFire: 2000, carbsEnergy: 2100, mealNumber: 6),
        HistoryMonth(month: "Octobre", trainingNumber: 1, carbsFire: 2200, carbsEnergy: 2300, mealNumber: 6),
        HistoryMonth(month: "Novembre", trainingNumber: 1, carbsFire: 2000, carbsEnergy: 2100, mealNumber: 5),
        HistoryMonth(month: "Décembre", trainingNumber: 1, carbsFire: 2200, carbsEnergy: 2300, mealNumber: 5)
    ]
    var dailyActivityHistory: [ActivityHistoryDay] {
        let grouped = Dictionary(grouping: activities) { "\($0.day)-\($0.month)-\($0.year)" }
        
        return grouped
            .map { key, activities in
                let parts = key.split(separator: "-")
                return ActivityHistoryDay(
                    day: String(parts[0]),
                    month: String(parts[1]),
                    year: String(parts[2]),
                    activities: activities
                )
            }
            .sorted { Int($0.day)! > Int($1.day)! }
    }
    
    
    var unifiedDailyHistory: [DayHistory] {
        let mealGroups = Dictionary(grouping: dailyMealHistory) {
            "\($0.day)-\($0.month)-\($0.year)"
        }

        let activityGroups = Dictionary(grouping: dailyActivityHistory) {
            "\($0.day)-\($0.month)-\($0.year)"
        }

        let allKeys = Set(mealGroups.keys).union(activityGroups.keys)

        return allKeys.compactMap { key in
            let comps = key.split(separator: "-")
            guard comps.count == 3 else { return nil }

            let day = String(comps[0])
            let month = String(comps[1])
            let year = String(comps[2])

            let meals = mealGroups[key]?.first?.meals ?? []
            let activities = activityGroups[key]?.first?.activities ?? []

            return DayHistory(
                day: day,
                month: month,
                year: year,
                meals: meals,
                activities: activities
            )
        }
        .sorted {
            ($0.year, $0.month, $0.day) > ($1.year, $1.month, $1.day)
        }
    }
    
    
    let dailyMealHistory: [MealHistory] = [
        MealHistory(
            day: "07",
            month: "Décembre",
            year: "2025",
            meals: [
                Meal(type: .breakfast, foods: [allFoods[2], allFoods[3]], totalCarbs: allFoods[2].glucides + allFoods[3].glucides),
                Meal(type: .lunch, foods: [allFoods[0], allFoods[4]], totalCarbs: allFoods[0].glucides + allFoods[4].glucides),
                Meal(type: .dinner, foods: [allFoods[1], allFoods[5]], totalCarbs: allFoods[1].glucides + allFoods[5].glucides),
                Meal(type: .collation, foods: [allFoods[2], allFoods[6]], totalCarbs: allFoods[2].glucides + allFoods[6].glucides),
                Meal(type: .collation, foods: [allFoods[0], allFoods[3]], totalCarbs: allFoods[0].glucides + allFoods[3].glucides)
            ]
        ),
        MealHistory(
            day: "06",
            month: "Décembre",
            year: "2025",
            meals: [
                Meal(type: .breakfast, foods: [allFoods[2], allFoods[3]], totalCarbs: allFoods[2].glucides + allFoods[3].glucides),
                Meal(type: .lunch, foods: [allFoods[0], allFoods[4]], totalCarbs: allFoods[0].glucides + allFoods[4].glucides),
                Meal(type: .dinner, foods: [allFoods[1], allFoods[6]], totalCarbs: allFoods[1].glucides + allFoods[6].glucides),
                Meal(type: .collation, foods: [allFoods[2], allFoods[5]], totalCarbs: allFoods[2].glucides + allFoods[5].glucides),
                Meal(type: .collation, foods: [allFoods[0], allFoods[3]], totalCarbs: allFoods[0].glucides + allFoods[3].glucides)
            ]
        ),
        MealHistory(
            day: "05",
            month: "Décembre",
            year: "2025",
            meals: [
                Meal(type: .breakfast, foods: [allFoods[0], allFoods[3]], totalCarbs: allFoods[0].glucides + allFoods[3].glucides),
                Meal(type: .lunch, foods: [allFoods[1], allFoods[4], allFoods[5]], totalCarbs: allFoods[1].glucides + allFoods[4].glucides + allFoods[5].glucides),
                Meal(type: .dinner, foods: [allFoods[1], allFoods[3]], totalCarbs: allFoods[1].glucides + allFoods[3].glucides),
                Meal(type: .collation, foods: [allFoods[2], allFoods[6]], totalCarbs: allFoods[2].glucides + allFoods[6].glucides),
                Meal(type: .collation, foods: [allFoods[0], allFoods[5]], totalCarbs: allFoods[0].glucides + allFoods[5].glucides)
            ]
        ),
        MealHistory(
            day: "04",
            month: "Décembre",
            year: "2025",
            meals: [
                Meal(type: .breakfast, foods: [allFoods[2], allFoods[3]], totalCarbs: allFoods[2].glucides + allFoods[3].glucides),
                Meal(type: .lunch, foods: [allFoods[0], allFoods[4]], totalCarbs: allFoods[0].glucides + allFoods[4].glucides),
                Meal(type: .dinner, foods: [allFoods[1], allFoods[6]], totalCarbs: allFoods[1].glucides + allFoods[6].glucides),
                Meal(type: .collation, foods: [allFoods[2], allFoods[5]], totalCarbs: allFoods[2].glucides + allFoods[5].glucides),
                Meal(type: .collation, foods: [allFoods[0], allFoods[3]], totalCarbs: allFoods[0].glucides + allFoods[3].glucides)
            ]
        ),
        MealHistory(
            day: "03",
            month: "Décembre",
            year: "2025",
            meals: [
                Meal(type: .breakfast, foods: [allFoods[1], allFoods[3]], totalCarbs: allFoods[1].glucides + allFoods[3].glucides),
                Meal(type: .lunch, foods: [allFoods[2], allFoods[4], allFoods[6]], totalCarbs: allFoods[2].glucides + allFoods[4].glucides + allFoods[6].glucides),
                Meal(type: .dinner, foods: [allFoods[0], allFoods[5]], totalCarbs: allFoods[0].glucides + allFoods[5].glucides),
                Meal(type: .collation, foods: [allFoods[1], allFoods[3]], totalCarbs: allFoods[1].glucides + allFoods[3].glucides),
                Meal(type: .collation, foods: [allFoods[2], allFoods[4]], totalCarbs: allFoods[2].glucides + allFoods[4].glucides)
            ]
        ),
        MealHistory(
            day: "02",
            month: "Décembre",
            year: "2025",
            meals: [
                Meal(type: .breakfast, foods: [allFoods[0], allFoods[6]], totalCarbs: allFoods[0].glucides + allFoods[6].glucides),
                Meal(type: .lunch, foods: [allFoods[1], allFoods[3], allFoods[5]], totalCarbs: allFoods[1].glucides + allFoods[3].glucides + allFoods[5].glucides),
                Meal(type: .dinner, foods: [allFoods[2], allFoods[4]], totalCarbs: allFoods[2].glucides + allFoods[4].glucides),
                Meal(type: .collation, foods: [allFoods[0], allFoods[5]], totalCarbs: allFoods[0].glucides + allFoods[5].glucides),
                Meal(type: .collation, foods: [allFoods[1], allFoods[6]], totalCarbs: allFoods[1].glucides + allFoods[6].glucides)
            ]
        ),
        MealHistory(
            day: "01",
            month: "Décembre",
            year: "2025",
            meals: [
                Meal(type: .breakfast, foods: [allFoods[2], allFoods[3]], totalCarbs: allFoods[2].glucides + allFoods[3].glucides),
                Meal(type: .lunch, foods: [allFoods[0], allFoods[4]], totalCarbs: allFoods[0].glucides + allFoods[4].glucides),
                Meal(type: .dinner, foods: [allFoods[1], allFoods[5]], totalCarbs: allFoods[1].glucides + allFoods[5].glucides),
                Meal(type: .collation, foods: [allFoods[2], allFoods[6]], totalCarbs: allFoods[2].glucides + allFoods[6].glucides),
                Meal(type: .collation, foods: [allFoods[0], allFoods[3]], totalCarbs: allFoods[0].glucides + allFoods[3].glucides)
            ]
        )
    ]
    
}



// MARK: - Données fake
let fakeExercises: [Exercise] = [
    Exercise(name: "Pump", type: "Musculation", defaultCaloriesPerMin: 12, motivationMessage: "Plus fort chaque jour !", imageName: "NailPump"),
    Exercise(name: "Haltéro", type: "Musculation", defaultCaloriesPerMin: 10, motivationMessage: "Force et précision !", imageName: "NailHaltero"),
    Exercise(name: "CrossFit", type: "Cardio", defaultCaloriesPerMin: 15, motivationMessage: "Dépasse-toi !", imageName: "NailCrossfit"),
    Exercise(name: "Street Workout", type: "Cardio", defaultCaloriesPerMin: 8, motivationMessage: "Bouge en plein air !", imageName: "NailStreetWorkout"),
    Exercise(name: "Course à pied", type: "Cardio", defaultCaloriesPerMin: 10, motivationMessage: "Accélère le rythme !", imageName: "NailRun"),
    Exercise(name: "Yoga", type: "Bien-être", defaultCaloriesPerMin: 5, motivationMessage: "Respire profondément.", imageName: "NailYoga"),
]

// MARK: - Fake Activities
let fakeActivities: [Activity] = [
    Activity(exercise: fakeExercises[0], duration: 30, caloriesBurned: 300, day: "01", month: "Décembre", year: "2025"),
    Activity(exercise: fakeExercises[1], duration: 45, caloriesBurned: 540, day: "01", month: "Décembre", year: "2025"),
    Activity(exercise: fakeExercises[2], duration: 20, caloriesBurned: 180, day: "02", month: "Décembre", year: "2025"),
    Activity(exercise: fakeExercises[3], duration: 40, caloriesBurned: 320, day: "02", month: "Décembre", year: "2025"),
    Activity(exercise: fakeExercises[4], duration: 35, caloriesBurned: 350, day: "03", month: "Décembre", year: "2025"),
    Activity(exercise: fakeExercises[5], duration: 25, caloriesBurned: 125, day: "03", month: "Décembre", year: "2025"),

    // 4 décembre 2025
    Activity(exercise: fakeExercises[0], duration: 30, caloriesBurned: 300, day: "04", month: "Décembre", year: "2025"),
    Activity(exercise: fakeExercises[1], duration: 40, caloriesBurned: 480, day: "04", month: "Décembre", year: "2025"),
    Activity(exercise: fakeExercises[2], duration: 35, caloriesBurned: 525, day: "04", month: "Décembre", year: "2025"),
    Activity(exercise: fakeExercises[3], duration: 25, caloriesBurned: 200, day: "04", month: "Décembre", year: "2025"),

    // 5 décembre 2025
    Activity(exercise: fakeExercises[4], duration: 30, caloriesBurned: 300, day: "05", month: "Décembre", year: "2025"),
    Activity(exercise: fakeExercises[5], duration: 25, caloriesBurned: 125, day: "05", month: "Décembre", year: "2025"),
    Activity(exercise: fakeExercises[0], duration: 50, caloriesBurned: 500, day: "05", month: "Décembre", year: "2025"),
    Activity(exercise: fakeExercises[2], duration: 40, caloriesBurned: 600, day: "05", month: "Décembre", year: "2025"),

    // 6 décembre 2025
    Activity(exercise: fakeExercises[1], duration: 45, caloriesBurned: 540, day: "06", month: "Décembre", year: "2025"),
    Activity(exercise: fakeExercises[5], duration: 20, caloriesBurned: 100, day: "06", month: "Décembre", year: "2025"),

    // 7 décembre 2025
    Activity(exercise: fakeExercises[0], duration: 40, caloriesBurned: 480, day: "07", month: "Décembre", year: "2025"),
    Activity(exercise: fakeExercises[3], duration: 25, caloriesBurned: 200, day: "07", month: "Décembre", year: "2025"),
]

var activitiesByDay: [String: [Activity]] {
    Dictionary(grouping: fakeActivities) { "\($0.day)-\($0.month)-\($0.year)" }
}
