//
//  CardAddFood.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct CardAddFood: View {
    let image: String
    let foodname: String
    @Binding var quantiteNumber: Int
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(.brownPrimary)
                .frame(width: 200, height: 200)
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 55)
                Text(foodname)
                    .font(.custom("Futura Condensed ExtraBold", size: 30))
                    .tracking(-1)
                    .foregroundStyle(Color.background)
                HStack(spacing: 10){
                    Button {
                        if quantiteNumber != 0{
                            quantiteNumber -= 50
                        }
                        
                    } label: {
                        Image(systemName: "minus")
                            .font(.system(size: 18, weight: .black))
                            .foregroundStyle(.brownPrimary)
                    }
                    .frame(width: 40, height: 40)
                    .background(Circle().fill(.pinkPrimary))
                    TextFieldFormObjectifCellCentered(userData: $quantiteNumber, label: "Quantité", width: 80, height: 40)
                    Button {
                        quantiteNumber += 50
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .black))
                            .foregroundStyle(.brownPrimary)
                    }
                    .frame(width: 40, height: 40)
                    .background(Circle().fill(.pinkPrimary))
                }
            }
            
        }
    }
}

#Preview {
    CardAddFood(image: "Chicken", foodname: "Poulet", quantiteNumber: .constant(0))
}
