//
//  HistoryMeal.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct HistoryMeal: View {
    @State private var vm = HistoryViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Titre fixe
                Text("HISTORIQUE")
                    .font(.custom("Futura Condensed ExtraBold", size: 40))
                    .tracking(-2)
                    .foregroundStyle(.brownPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.center)
                    .background(Color.background)
                
                ScrollView {
                    VStack(spacing: 30) {
                        ForEach(vm.dailyMealHistory) { dayHistory in
                            VStack(spacing: 15) {
                                // Date
                                DateHistory(day: dayHistory.day,
                                            month: dayHistory.month,
                                            year: dayHistory.year)
                                    .frame(width: 340, alignment: .leading)
                                
                                // Grille 2x2 avec LazyVGrid
                                LazyVGrid(columns: columns, spacing: 15) {
                                    ForEach(dayHistory.meals) { meal in
                                        NavigationLink {
                                            DetailMealView(meal: meal)
                                        } label: {
                                            CardMealhistory(
                                                name: meal.type.rawValue,
                                                kcal: meal.foods.reduce(0) { $0 + $1.calories }
                                            )
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        Spacer(minLength: 20)
                    }
                    .padding(.vertical, 20)
                }
                .background(Color.background)
                .scrollIndicators(.hidden)
            }
            .background(Color.background.ignoresSafeArea())
        }
    }
}

#Preview {
    HistoryMeal()
}
