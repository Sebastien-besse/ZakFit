//
//  CardDetailMealFood.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct CardDetailMealFood: View {
    let image: String
    let foodname: String
    let proteins: Int
    let glucides: Int
    let lipids: Int
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(.brownPrimary)
                .frame(width: 208, height: 300)
            VStack(alignment: .center, spacing: 38){
                Text(foodname)
                .font(.custom("Futura Condensed ExtraBold", size: 40))
                .tracking(-1)
                .foregroundStyle(Color.background)
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                HStack(spacing: 20){
                    circleFood(color: .pinkPrimary, data: proteins, type: "Proteins")
                    circleFood(color: .yellowPrimary, data: lipids, type: "Lipides")
                    circleFood(color: .greenPrimary, data: glucides, type: "Glucides")
                }
            }
        }
    }
    
    func circleFood(color: Color, data: Int, type: String) -> some View{
        VStack{
            ZStack{
                Circle()
                    .stroke(color, lineWidth: 6)
                    .frame(width: 48, height: 48)
                Text("\(data)g")
                    .font(.custom("Futura Medium", size: 16))
                    .tracking(-1)
                    .foregroundStyle(Color.background)
            }
            Text(type)
                .font(.custom("Futura Medium", size: 14))
                .tracking(-1)
                .foregroundStyle(Color.background)
        }
        
        
    }
}

#Preview {
    CardDetailMealFood(image: "Chicken", foodname: "Poulet", proteins: 24, glucides: 8, lipids: 3)
}
