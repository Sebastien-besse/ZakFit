//
//  PelletFood.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct PelletFood: View {
    @Binding var foodname: String
    var onDelete: (() -> Void)? = nil
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(.pinkPrimary)
                .frame(width: 108, height: 30)
            
            HStack(spacing: 12) {
                Text(foodname)
                    .font(.custom("Futura Bold", size: 16))
                    .foregroundColor(.brownPrimary)
                
                Image(systemName: "multiply")
                    .foregroundColor(.brownPrimary)
                    .onTapGesture {
                        onDelete?()
                    }
            }
        }
    }
}

#Preview {
    PelletFood(foodname: .constant("Poulet"))
}
