//
//  CardMonthHistory.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct CardMonthHistory: View {
    let month: HistoryMonth
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.brownPrimary.opacity(0.7))
                .frame(width: 360, height: 240)
            
            VStack {
                HStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.pinkPrimary)
                        .frame(width: 68, height: 24)
                        .overlay {
                            Text(month.month)
                                .font(.custom("Futura Medium", size: 12))
                                .tracking(-1)
                                .foregroundStyle(.brownPrimary)
                        }
                    Spacer()
                    VStack(alignment: .center) {
                        Image("HaltereGrey")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                        Text("\(month.trainingNumber) entr/jour")
                            .font(.custom("Futura Medium", size: 12))
                            .tracking(-1)
                            .foregroundStyle(Color.background)
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .center) {
                    Text("Brûlé")
                        .font(.custom("Futura Medium", size: 18))
                        .tracking(-1)
                        .foregroundStyle(Color.background)
                    Image(systemName: "flame.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .foregroundStyle(.yellowPrimary)
                    Text("\(month.carbsFire) Kcal / jour")
                        .font(.custom("Futura Medium", size: 14))
                        .tracking(-1)
                        .foregroundStyle(Color.background)
                }
                
                HStack(alignment: .top) {
                    VStack(alignment: .center) {
                        Image("Energy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Text("\(month.carbsEnergy) Kcal / jour")
                            .font(.custom("Futura Medium", size: 12))
                            .tracking(-1)
                            .foregroundStyle(Color.background)
                    }
                    Spacer()
                    VStack(alignment: .center) {
                        Image("Meal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Text("\(month.mealNumber) repas / jour")
                            .font(.custom("Futura Medium", size: 12))
                            .tracking(-1)
                            .foregroundStyle(Color.background)
                    }
                }
                .padding(.horizontal)
            }
            .shadow(radius: 3, x: 0, y: 4)
        }
        .frame(width: 310, height: 200)
        .padding(.vertical, 20)
    }
}

#Preview {
    CardMonthHistory(month: .init(month: "Jancier", trainingNumber: 1, carbsFire: 2000, carbsEnergy: 2100, mealNumber: 5))
}
