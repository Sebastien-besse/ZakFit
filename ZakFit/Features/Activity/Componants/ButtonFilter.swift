//
//  ButtonFilter.swift
//  ZakFit
//
//  Created by apprenant152 on 02/12/2025.
//

import SwiftUI

import SwiftUI

struct ButtonFilter: View {
    let name: String
    let isFilter: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(name)
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(isFilter ? Color.blue.opacity(0.9) : Color.clear)
                .foregroundColor(isFilter ? .white : .primary)
                .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    ButtonFilter(name: "", isFilter: false, action: {})
}
