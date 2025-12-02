//
//  CardCell.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import SwiftUI

struct CardCell: View {
    let image: String
    @Binding var text: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(.brownPrimary)
                .frame(width: 148, height: 148)
            VStack(spacing: 20){
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 38, height: 38)
                Text(text)
                    .font(.custom("Futura Condensed ExtraBold", size: 14))
                    .tracking(-0.4)
                    .foregroundStyle(Color.background)
            }
        }
    }
}

#Preview {
    CardCell(image: "Rocket", text: .constant("Prise de muscle"))
}
