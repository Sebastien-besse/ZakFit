//
//  DateDetailActivityCell.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct DateDetailActivityCell: View {
    let day: String
    let month: String
    let year: String

    var body: some View {
        HStack(spacing: 4) {
            contentDate(isYear: false, day)
            Text("-")
                .font(.custom("Futura Bold", size: 16))
                .tracking(-1)
            contentDate(isYear: false, month)
            Text("-")
                .font(.custom("Futura Bold", size: 16))
                .tracking(-1)
            contentDate(isYear: true, year)
        }
    }

    func contentDate(isYear: Bool, _ text: String) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.yellow)
            .frame(width: isYear ? 58 : 34, height: 32)
            .overlay {
                Text(text)
                    .font(.custom("Futura Bold", size: 16))
                    .tracking(-1)
            }
    }
}

#Preview {
    DateDetailActivityCell(day: "21", month: "12", year: "2025")
}
