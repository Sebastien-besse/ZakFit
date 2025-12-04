//
//  HistoryView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI


struct HistoryView: View {
    @State private var vm = HistoryViewModel()
    
    // Filtre du haut : Semaine / Mois
    @State private var selectedPeriod: HistoryPeriod = .week
    
    // Filtre du bas : Activités / Repas / Mix
    @State private var selectedFilter: HistoryFilter = .activities
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // —————————————————————— TITRE
                Text("HISTORIQUE")
                    .font(.custom("Futura Condensed ExtraBold", size: 40))
                    .tracking(-2)
                    .foregroundStyle(.brownPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .background(Color.background)
                
                headerPeriodFilter
                    .padding(.top, 10)

                if selectedPeriod == .week {
                    headerHistoryFilter
                        .padding(.vertical, 10)
                }
                
                ScrollView {
                    VStack(spacing: 30) {
                        
                        switch selectedPeriod {
                        case .week:
                            weekContent
                        case .month:
                            HistoryMonthView()
                                .padding(.top, 10)
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

extension HistoryView {
    
    var weekContent: some View {
        Group {
            switch selectedFilter {
                
            // ————————————— ACTIVITÉS PAR JOUR
            case .activities:
                ForEach(vm.dailyActivityHistory) { day in
                    dayBlock(date: day.day, month: day.month, year: day.year) {
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(day.activities) { activity in
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
                
            case .meals:
                ForEach(vm.dailyMealHistory) { day in
                    dayBlock(date: day.day, month: day.month, year: day.year) {
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(day.meals) { meal in
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
                }
                
            case .mixed:
                ForEach(vm.unifiedDailyHistory) { day in
                    dayBlock(date: day.day, month: day.month, year: day.year) {
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(day.combined) { entry in
                                switch entry {
                                    
                                case .meal(let meal):
                                    NavigationLink {
                                        DetailMealView(meal: meal)
                                    } label: {
                                        CardMealhistory(
                                            name: meal.type.rawValue,
                                            kcal: meal.foods.reduce(0) { $0 + $1.calories }
                                        )
                                    }
                                    
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
                }
            }
        }
    }
}

extension HistoryView {
    @ViewBuilder
    func dayBlock<Content: View>(
        date: String,
        month: String,
        year: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(spacing: 15) {
            DateHistory(day: date, month: month, year: year)
                .frame(width: 340, alignment: .leading)
            content()
        }
        .padding(.horizontal, 20)
    }
}
extension HistoryView {
    var headerPeriodFilter: some View {
        RoundedRectangle(cornerRadius: 7)
            .fill(Color.brownPrimary.opacity(0.4))
            .overlay {
                HStack(spacing: 11) {
                    ForEach(HistoryPeriod.allCases, id: \.self) { period in
                        ButtonFilter(
                            name: period.rawValue,
                            isFilter: selectedPeriod == period
                        ) { selectedPeriod = period }
                        
                        if period != HistoryPeriod.allCases.last {
                            Divider()
                        }
                    }
                }
                .frame(width: 360, height: 36)
            }
            .frame(width: 220, height: 36)
    }
}

extension HistoryView {
    var headerHistoryFilter: some View {
        RoundedRectangle(cornerRadius: 7)
            .fill(Color.brownPrimary.opacity(0.5))
            .overlay {
                HStack(spacing: 11) {
                    ForEach(HistoryFilter.allCases, id: \.self) { filter in
                        ButtonFilter(
                            name: filter.rawValue,
                            isFilter: selectedFilter == filter
                        ) { selectedFilter = filter }
                        
                        if filter != HistoryFilter.allCases.last {
                            Divider()
                        }
                    }
                }
                .frame(width: 360, height: 36)
            }
            .frame(width: 344, height: 36)
    }
}

#Preview {
    HistoryView()
}
