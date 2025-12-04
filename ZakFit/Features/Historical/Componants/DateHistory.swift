//
//  DateHistory.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct DateHistory: View {
    let day: String
    let month: String
    let year: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.pinkPrimary)
            .frame(width: 130, height: 30)
            .overlay{
                Text("\(day) \(month) \(year)")
                    .font(.custom("Futura Medium", size: 14))
                    .tracking(-1)
                    .foregroundStyle(.brownPrimary)
            }
    }
}

#Preview {
    DateHistory(day: "21", month: "12", year: "2025")
}
