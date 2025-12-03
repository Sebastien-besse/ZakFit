//
//  CardCarouselCell.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import SwiftUI

struct CardCarouselCell: View {
    let image: String
    let exercice: String
    let text: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 6)
                .fill(.brownPrimary)
                .frame(width: 240, height: 280)
            VStack(spacing: 20){
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 104, height: 102)
                
                Text(exercice)
                    .font(.custom("Futura Condensed ExtraBold", size: 24))
                    .tracking(-1)
                    .foregroundStyle(Color.background)
                Text(text)
                    .font(.custom("Futura", size: 14))
                    .tracking(-1)
                    .foregroundStyle(Color.background)
                 
            }
           
        }
        
    }
}

#Preview {
    CardCarouselCell(image: "NailPump", exercice: "Pump", text: "Bouge toi !")
}
