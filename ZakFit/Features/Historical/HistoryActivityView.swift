//
//  HistoryActivityView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//
import SwiftUI

struct HistoryActivityView: View {
    @State private var vm = HistoryViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
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
                        
                        ForEach(vm.dailyActivityHistory) { dayGroup in
                            VStack(spacing: 15) {
                                
                                DateHistory(day: dayGroup.day,
                                            month: dayGroup.month,
                                            year: dayGroup.year)
                                    .frame(width: 340, alignment: .leading)
                                
                                LazyVGrid(columns: columns, spacing: 15) {
                                    ForEach(dayGroup.activities) { activity in
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
    HistoryActivityView()
}
