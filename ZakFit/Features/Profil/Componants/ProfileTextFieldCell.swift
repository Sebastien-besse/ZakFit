//
//  ProfileTextFieldCell.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import SwiftUI

struct ProfileTextFieldCell: View {
    let width: CGFloat
    @Binding var text: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.background)
            .frame(width: width, height: 50)
            .shadow(color: .black.opacity(0.15), radius: 3, y: 3)
            .overlay(
                TextField("", text: $text)
                    .font(.custom("Futura Condensed ExtraBold", size: 20))
                    .padding(.horizontal)
                    .foregroundStyle(.brownPrimary)
            )
    }
}


#Preview {
    ProfileTextFieldCell(width: 50, text: .constant(""))
}
