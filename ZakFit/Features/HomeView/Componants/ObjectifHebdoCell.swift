//
//  ObjectifHebdoCell.swift
//  ZakFit
//
//  Created by Sebastien Besse on 03/12/2025.
//

import SwiftUI

struct ObjectifHebdoCell: View {
    var succes: CGFloat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Objectif hebdomadaire")
                .font(.custom("Futura Condensed", size: 12))
                .foregroundStyle(.brownPrimary)
            
            ZStack(alignment: .leading) {
                // Barre de fond marron
                RoundedRectangle(cornerRadius: 7)
                    .fill(.brownPrimary)
                    .frame(width: 300, height: 36)
                
                // Barre grise (max)
                RoundedRectangle(cornerRadius: 50)
                    .fill(.greyPrimary)
                    .frame(width: 240, height: 12)
                    .padding(.leading, 10)
                
                // Barre verte (succès), collée à gauche
                RoundedRectangle(cornerRadius: 50)
                    .fill(.greenPrimary)
                    .frame(width: 240 * (succes / 100), height: 12)
                    .padding(.leading, 10)
                
                // Pourcentage, aligné à droite à l'intérieur du rectangle
                HStack {
                    Spacer()
                    Text("\(Int(succes)) %")
                        .font(.custom("Futura", size: 12))
                        .foregroundStyle(Color.background)
                        .padding(.trailing, 12)
                }
                .frame(width: 300)
            }
        }
    }
}

#Preview {
    ObjectifHebdoCell(succes: 75)
}
