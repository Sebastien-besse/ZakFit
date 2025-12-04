//
//  DetailActivityView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 03/12/2025.
//

import SwiftUI

struct DetailActivityView: View {
    let activity: Activity   // <- ajouter cette ligne

    var body: some View {
        VStack(spacing: 20){
            Text("Détail séance")
                .font(.custom("Futura Condensed ExtraBold", size: 40))
                .tracking(-1)
                .foregroundStyle(.brownPrimary)

            DateDetailActivityCell(day: activity.day,
                                   month: activity.month,
                                   year: activity.year)
                .padding(.vertical)

            CardDetailActivityCell(image: activity.exercise.imageName,
                                   type: activity.exercise.type,
                                   exercice: activity.exercise.name)

            // Durée et calories
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.brownPrimary)
                        .frame(width: 150, height: 140)
                    VStack{
                        Text("Durée")
                            .font(.custom("Futura Condensed ExtraBold", size: 20))
                            .tracking(-1)
                            .foregroundStyle(Color.background)
                        Image("HaltereYellow")
                        Text("\(activity.duration) minutes")
                            .font(.custom("Futura", size: 20))
                            .tracking(-1)
                            .foregroundStyle(Color.background)
                    }
                }

                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.brownPrimary)
                        .frame(width: 150, height: 140)
                    VStack{
                        Text("Brûlé")
                            .font(.custom("Futura Condensed ExtraBold", size: 20))
                            .tracking(-1)
                            .foregroundStyle(Color.background)
                        Image(systemName: "flame.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 45, height: 50)
                            .foregroundStyle(.yellowPrimary)
                        Text("\(activity.caloriesBurned) Kcal")
                            .font(.custom("Futura", size: 20))
                            .tracking(-1)
                            .foregroundStyle(Color.background)
                    }
                }
            }

            Button(role: .destructive) {
                print("Retour")
            } label: {
                Text("Retour")
                    .font(.custom("Futura Condensed ExtraBold", size: 22))
                    .foregroundColor(Color.background)
                    .padding()
                    .frame(width: 200)
                    .background(.brownPrimary)
                    .cornerRadius(15)
                    .shadow(radius: 4)
            }
            .frame(height: 170, alignment: .bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.background)
    }
}

#Preview {
    DetailActivityView(activity: .init(exercise: .init(name: "Pump", type: "Musculation", defaultCaloriesPerMin: 8, motivationMessage: "Dicippline", imageName: "NailPump"), duration: 90, caloriesBurned: 405, day: "04", month: "12", year: "2025"))
}
