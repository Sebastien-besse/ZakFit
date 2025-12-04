//
//  Meal.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import Foundation

enum TypeMeal: String, CaseIterable, Identifiable {
    case breakfast = "Petit déjeuner"
    case dinner = "Diner"
    case lunch = "Déjeuner"
    case collation = "Collation"
    
    var id: String { self.rawValue }
}

enum FoodType: String {
    case protein = "Protéine"
    case carb = "Glucide"
}

struct Meal: Identifiable{
    
    let id = UUID()
    let type: TypeMeal
    let foods: [Food]
    let totalCarbs: Int
}

struct Food: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let image: String
    let proteins: Int
    let glucides: Int
    let lipids: Int
    let calories: Int
    let type: FoodType
}




let fakeMeals: [Meal] = [
    
    // Petit Déjeuner
    Meal(
        type: .breakfast,
        foods: [
            Food(
                name: "Œufs",
                image: "Egg",
                proteins: 12,
                glucides: 1,
                lipids: 10,
                calories: 150,
                type: .protein
            ),
            Food(
                name: "Pâtes",
                image: "Pasta",
                proteins: 8,
                glucides: 30,
                lipids: 3,
                calories: 180,
                type: .carb
            )
        ],
        totalCarbs: 1 + 30
    ),
    
    // Déjeuner
    Meal(
        type: .lunch,
        foods: [
            Food(
                name: "Poulet",
                image: "Chicken",
                proteins: 31,
                glucides: 0,
                lipids: 4,
                calories: 165,
                type: .protein
            ),
            Food(
                name: "Riz",
                image: "Rice",
                proteins: 4,
                glucides: 36,
                lipids: 1,
                calories: 170,
                type: .carb
            ),
            Food(
                name: "Lentilles",
                image: "Lentille",
                proteins: 9,
                glucides: 20,
                lipids: 0,
                calories: 116,
                type: .carb
            )
        ],
        totalCarbs: 0 + 36 + 20
    ),
    
    // Dîner
    Meal(
        type: .dinner,
        foods: [
            Food(
                name: "Poisson",
                image: "Fish",
                proteins: 22,
                glucides: 0,
                lipids: 12,
                calories: 190,
                type: .protein
            ),
            Food(
                name: "Pâtes",
                image: "Pasta",
                proteins: 7,
                glucides: 42,
                lipids: 1,
                calories: 210,
                type: .carb
            )
        ],
        totalCarbs: 0 + 42
    )
]

let allFoods: [Food] = [

    // ——— PROTÉINES ———
    Food(
        name: "Poulet",
        image: "Chicken",
        proteins: 31,
        glucides: 0,
        lipids: 4,
        calories: 165,
        type: .protein
    ),
    Food(
        name: "Poisson",
        image: "Fish",
        proteins: 22,
        glucides: 0,
        lipids: 12,
        calories: 190,
        type: .protein
    ),
    Food(
        name: "Œufs",
        image: "Egg",
        proteins: 12,
        glucides: 1,
        lipids: 10,
        calories: 150,
        type: .protein
    ),

    // ——— GLUCIDES ———
    Food(
        name: "Pâtes",
        image: "Pasta",
        proteins: 8,
        glucides: 30,
        lipids: 3,
        calories: 180,
        type: .carb
    ),
    Food(
        name: "Riz",
        image: "Rice",
        proteins: 4,
        glucides: 36,
        lipids: 1,
        calories: 170,
        type: .carb
    ),
    Food(
        name: "Lentilles",
        image: "Lentille",
        proteins: 9,
        glucides: 20,
        lipids: 0,
        calories: 116,
        type: .carb
    ),
    Food(
        name: "Quinoa",
        image: "Quinoa",
        proteins: 8,
        glucides: 21,
        lipids: 4,
        calories: 120,
        type: .carb
    )
]

