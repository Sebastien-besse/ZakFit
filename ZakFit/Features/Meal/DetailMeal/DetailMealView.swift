//
//  DetailMealView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI
import CardCarousel

struct DetailMealView: View {
    let meal: Meal
    @State private var selectedFoodID: UUID? = nil
    
    var body: some View {
        VStack(spacing: 40) {
            Text("TON REPAS")
                .font(.custom("Futura Condensed ExtraBold", size: 40))
                .tracking(-2)
                .foregroundStyle(.brownPrimary)
                .frame(width: 200)
                .padding(.top, 20)
            
            Image("NailDetailMeal")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
            
            HStack(spacing: 14){
                CardDetailMeal(text: meal.type.rawValue, isKcal: false)
                
                RoundedRectangle(cornerRadius: 30)
                    .fill(.brownPrimary)
                    .frame(width: 4, height: 60)
                
                CardDetailMeal(text: "\(totalCalories(for: meal)) Kcal", isKcal: true)
            }
            
            Carousel(meal.foods, id: \.id, isLooping: true) { food in
                VStack {
                    CardDetailMealFood(
                        image: food.image,
                        foodname: food.name,
                        proteins: food.proteins,
                        glucides: food.glucides,
                        lipids: food.lipids
                    )
                }
            }
            .frame(height: 340)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.background.ignoresSafeArea())
    }
    
    
    // ——— AUTO CALC calories from foods
    func totalCalories(for meal: Meal) -> Int {
        meal.foods.reduce(0) { $0 + $1.calories }
    }
}

#Preview {
    DetailMealView(meal: fakeMeals[1])
}
