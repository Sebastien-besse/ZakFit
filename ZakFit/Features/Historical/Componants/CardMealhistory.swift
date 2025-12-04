//
//  CardMealhistory.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct CardMealhistory: View {
    let name: String
    let kcal: Int
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(.brownPrimary)
                .frame(width: 150, height: 150)
            VStack(spacing: 8){
                Text("\(kcal) Kcal")
                    .font(.custom("Futura Medium", size: 11))
                    .tracking(-1)
                    .foregroundStyle(Color.background)
                    .frame(minWidth: 130, alignment: .trailing)
                Image("Meal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                Text(name)
                    .font(.custom("Futura Bold", size: 18))
                    .tracking(-1)
                    .foregroundStyle(Color.background)
            }
        }
    }
}

#Preview {
    CardMealhistory(name: "Diner", kcal: 429)
}
