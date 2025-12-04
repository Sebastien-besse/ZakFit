//
//  CardDetailMeal.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct CardDetailMeal: View {
    let text : String
    var isKcal : Bool
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(isKcal ? .brownPrimary : .yellowPrimary)
                .frame(width: 170, height: 60)
            if isKcal{
                HStack(alignment: .center, spacing: 30){
                    Image(systemName: "flame.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(.yellowPrimary)
                    Text(text)
                        .font(.custom("Futura Bold", size: 18))
                        .tracking(-1)
                        .foregroundStyle(Color.background)
                }
            }
            else{
                Text(text)
                    .font(.custom("Futura Bold", size: 18))
                    .tracking(-1)
                    .foregroundStyle(Color.brownPrimary)
            }
        }
        
    }
}

#Preview {
    CardDetailMeal(text: "Petit déjeuner", isKcal: false)
}
