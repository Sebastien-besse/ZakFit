//
//  ActivityDayCell.swift
//  ZakFit
//
//  Created by Sebastien Besse on 03/12/2025.
//

import SwiftUI

struct ActivityDayCell: View {
    var exercice: String
    var type: String
    var time: Int
    var body: some View {
        VStack(alignment: .leading){
            Text("Séance du jour")
                .font(.custom("Futura Condensed", size: 12))
                .foregroundStyle(.brownPrimary)
            RoundedRectangle(cornerRadius: 8)
                .fill(.brownPrimary)
                .frame(width: 234, height: 40)
                .overlay{
                    HStack(spacing: 14){
                        Text(exercice)
                            .font(.custom("Futura Condensed ExtraBold", size: 18))
                            .tracking(-1)
                            .foregroundStyle(Color.background)
                        RoundedRectangle(cornerRadius: 7)
                            .fill(.yellowPrimary)
                            .frame(width: 74, height: 16)
                            .overlay{
                                Text(type)
                                    .font(.custom("Futura Condensed ExtraBold", size: 12))
                                    .foregroundStyle(.brownPrimary)
                            }
                        
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color.background)
                            .frame(width: 74, height: 16)
                            .overlay{
                                Text("\(time) minutes")
                                    .font(.custom("Futura Condensed ExtraBold", size: 12))
                                    .foregroundStyle(.brownPrimary)
                            }
                    }
                    
                }
        }
       
        
    }
}

#Preview {
    ActivityDayCell(exercice: "Pump", type: "Musculation", time: 90)
}
