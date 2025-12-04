//
//  ObjectifCalorieView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 03/12/2025.
//

import SwiftUI

struct ObjectifCalorieView: View {
    @State var frequence: Int
    var onClose: () -> Void
    var body: some View {
        ZStack(alignment: .topTrailing) {

            // --- TON CONTENU EXACT ---
            VStack(spacing: 50){
                Text("Mon objectif journalier")
                    .font(.custom("Futura Condensed ExtraBold", size: 40))
                    .tracking(-2)
                    .foregroundStyle(.brownPrimary)
                    .frame(width: 200)
                    .multilineTextAlignment(.center)

                    ZStack{
                        RoundedRectangle(cornerRadius: 7)
                            .fill(.brownPrimary)
                            .frame(width: 310, height: 400)

                        VStack(alignment: .leading, spacing: 40){
                            ContentObjectifCell(
                                value: $frequence,
                                icone: "FlameObjectif",
                                description: "Kcal",
                                label: "Frequence"
                            )
                            
                            ContentObjectifCell(
                                value: $frequence,
                                icone: "Chicken",
                                description: "g",
                                label: "Frequence"
                            )
                            
                            ContentObjectifCell(
                                value: $frequence,
                                icone: "Glucide",
                                description: "g",
                                label: "Calories"
                            )

                            ContentObjectifCell(
                                value: $frequence,
                                icone: "Lipid",
                                description: "g",
                                label: "Durée"
                            )
                        }
                    }
                

                Button(role: .destructive) {
                    print("créer")
                } label: {
                    Text("Ajouter")
                        .font(.custom("Futura Condensed ExtraBold", size: 22))
                        .foregroundColor(Color.background)
                        .padding()
                        .frame(width: 200)
                        .background(.brownPrimary)
                        .cornerRadius(30)
                        .shadow(radius: 4)
                }
                .padding(.top, 50)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)

            // --- BOUTON DE FERMETURE ---
            Button(action: { onClose() }) {
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.brownPrimary)
                    .padding(12)
                    .background(
                        Circle()
                            .fill(.pinkPrimary)
                            .shadow(radius: 4)
                    )
            }
            .padding()
        }
        .background(Color.background.ignoresSafeArea())
    }
}

#Preview {
    ObjectifCalorieView(frequence: 8, onClose: {})
}
