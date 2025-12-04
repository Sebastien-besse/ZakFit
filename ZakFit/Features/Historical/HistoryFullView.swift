//
//  HistoryFullView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct HistoryFullView: View {
    @State private var vm = HistoryViewModel()

    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                // ——— Titre fixe
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

                        // ——— Pour chaque jour
                        ForEach(vm.unifiedDailyHistory) { day in
                            VStack(spacing: 20) {

                                // ——— Date
                                DateHistory(day: day.day,
                                            month: day.month,
                                            year: day.year)
                                .frame(width: 340, alignment: .leading)

                                // ——— Grille unique avec repas + activités mélangés
                                LazyVGrid(columns: columns, spacing: 15) {

                                    ForEach(day.combined) { entry in
                                        switch entry {

                                        // ——— REPAS
                                        case .meal(let meal):
                                            NavigationLink {
                                                DetailMealView(meal: meal)
                                            } label: {
                                                CardMealhistory(
                                                    name: meal.type.rawValue,
                                                    kcal: meal.foods.reduce(0) { $0 + $1.calories }
                                                )
                                            }

                                        // ——— ACTIVITÉS
                                        case .activity(let activity):
                                            NavigationLink {
                                                DetailActivityView(activity: activity)
                                            } label: {
                                                CardActivtyhistory(
                                                    image: activity.exercise.imageName,
                                                    name: activity.exercise.name,
                                                    isDate: false
                                                )
                                            }
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
    HistoryFullView()
}

