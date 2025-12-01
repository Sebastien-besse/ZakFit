//
//  TextFieldFormCell.swift
//  ZakFit
//
//  Created by apprenant152 on 01/12/2025.
//

import SwiftUI

struct TextFieldFormCell: View {
    @Binding var userData: String
    var label: String
    let (width, height) : (CGFloat, CGFloat)
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.background)
            .frame(width: width, height: height)
            .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
            .overlay {
                TextField(label, text: $userData)
                    .font(.custom("Futura Condensed ExtraBold", size: 20))
                    .foregroundStyle(.brownPrimary)
                    .padding()
                    
            }
    }
}



struct SecureFieldFormCell: View {
    @Binding var password: String
    let width: CGFloat
    let height: CGFloat
    let isConfirmPassword: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.background)
            .frame(width: width, height: height)
            .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 3)
            .overlay{
                SecureField(isConfirmPassword ? "Confirmer mot de passe" : "Mot de passe", text: $password)
                    .font(.custom("Futura Condensed ExtraBold", size: 20))
                    .foregroundStyle(.brownPrimary)
                    .frame(width: width)
                    .padding(.leading, 30)
//                    .overlay(alignment: .trailing) {
//                        if password.count < 6 && !password.isEmpty {
//                            Image(systemName: "exclamationmark.triangle.fill")
//                                .foregroundStyle(.yellow)
//                        }
//                    }
            }
    }
}



#Preview {
    TextFieldFormCell(userData: .constant(""), label: "Email", width: 300, height: 50)
    SecureFieldFormCell(password: .constant(""), width: 300, height: 50, isConfirmPassword: true)
}
