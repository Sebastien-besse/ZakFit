//
//  CardDetailActivityCell.swift
//  ZakFit
//
//  Created by Sebastien Besse on 03/12/2025.
//

import SwiftUI

struct CardDetailActivityCell: View {
    let image: String
    let type: String
    let exercice: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(.brownPrimary)
                .frame(width: 300, height: 184)
            Image("badgeActivity")
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .padding(.bottom, 160)
                .padding(.leading, 270)
            VStack{
                HStack{
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                    VStack{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.yellowPrimary)
                            .frame(width: 106, height: 33)
                            .overlay{
                                Text(type)
                                    .font(.custom("Futura Bold", size: 16))
                                    .tracking(-1)
                            }
                        Text("Wooow ! tu te les données mon poulet !")
                            .font(.custom("Futura", size: 16))
                            .tracking(-1)
                            .foregroundStyle(Color.background)
                            .frame(width: 180)
                    }
                    
                }
                Text(exercice)
                    .font(.custom("Futura Condensed ExtraBold", size: 20))
                    .tracking(-1)
                    .foregroundStyle(Color.background)
                    .padding(.trailing, 184)
            }
        }
    }
}

#Preview {
    CardDetailActivityCell(image: "NailPump", type: "Musculation", exercice: "Pump")
}
