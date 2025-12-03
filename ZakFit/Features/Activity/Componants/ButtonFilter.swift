//
//  ButtonFilter.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import SwiftUI


struct ButtonFilter: View {
    let name: String
    let isFilter: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(name)
                .font(.custom("Futura Bold", size: 14 ))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(isFilter ? Color.yellowPrimary : Color.clear)
                .foregroundColor(.brownPrimary)
                .cornerRadius(7)
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    ButtonFilter(name: "", isFilter: false, action: {})
}
