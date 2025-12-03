//
//  TextFiedObjectifCell.swift
//  ZakFit
//
//  Created by Sebastien Besse on 03/12/2025.
//

import SwiftUI

struct ContentObjectifCell: View {
    
    @Binding var value: Int
    let icone : String
    let description: String
    let label: String
    var body: some View {
        HStack(alignment: .center, spacing: 10){
            Image(icone)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .padding(.trailing)
            TextFieldFormObjectifCell(userData: $value, label: label, width: 140, height: 50)
            Text(description)
                .font(.custom("Futura Medium", size: 20))
                .tracking(-1)
                .foregroundStyle(Color.background)
        }
    }
}

#Preview {
    ContentObjectifCell(value: .constant(23), icone: "HeartFrequences", description: "Sem", label: "Fréquences")
}
