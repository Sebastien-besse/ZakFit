//
//  ObjectifActivityView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 03/12/2025.
//

import SwiftUI

struct ObjectifActivityView: View {
    @State var frequence: Int = 4
    @State var calories: Int = 345
    @State var time: Int = 90
    var onClose: () -> Void    // ← callback pour la fermeture

    var body: some View {
        ZStack(alignment: .topTrailing) {

            // --- TON CONTENU EXACT ---
            VStack(spacing: 50){
                Text("MON OBJECTIF HEBDO")
                    .font(.custom("Futura Condensed ExtraBold", size: 40))
                    .tracking(-2)
                    .foregroundStyle(.brownPrimary)
                    .frame(width: 300)
                    .multilineTextAlignment(.center)

                VStack{
                    Text("Par semaines")
                        .font(.custom("Futura Condensed", size: 18))
                        .foregroundStyle(.brownPrimary)

                    ZStack{
                        RoundedRectangle(cornerRadius: 7)
                            .fill(.brownPrimary)
                            .frame(width: 310, height: 80)

                        ContentObjectifCell(
                            value: $frequence,
                            icone: "HeartObjectif",
                            description: "Sem",
                            label: "Frequence"
                        )
                    }
                }

                VStack{
                    Text("Par séance")
                        .font(.custom("Futura Condensed", size: 18))
                        .foregroundStyle(.brownPrimary)

                    ZStack{
                        RoundedRectangle(cornerRadius: 7)
                            .fill(.brownPrimary)
                            .frame(width: 310, height: 200)

                        VStack(spacing: 20){
                            ContentObjectifCell(
                                value: $calories,
                                icone: "FlameObjectif",
                                description: "Kcal",
                                label: "Calories"
                            )

                            ContentObjectifCell(
                                value: $time,
                                icone: "Timer",
                                description: "Min",
                                label: "Durée"
                            )
                        }
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
    ObjectifActivityView(onClose: {})
}
