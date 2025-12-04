//
//  HistoryMonthView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct HistoryMonthView: View {
    @State private var vm = HistoryViewModel()
    
    var body: some View {
        VStack{
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(vm.months, id: \.month) { month in
                        CardMonthHistory(month: month)
                    }
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 40)
            }
            .background(Color.background)
            .scrollIndicators(.hidden)
        }
        .background(Color.background.ignoresSafeArea())
    }
}

#Preview {
    HistoryMonthView()
}
