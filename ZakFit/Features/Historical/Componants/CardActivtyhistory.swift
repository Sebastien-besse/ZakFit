//
//  CardActivtyhistory.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct CardActivtyhistory: View {
    let image: String
    let name: String
    var isDate: Bool
    var date: String?
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(.brownPrimary)
                .frame(width: 150, height: 150)
            VStack(spacing: 8){
                if isDate{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.yellowPrimary)
                        .frame(width: 60, height: 20)
                        .overlay{
                            Text(date ?? "")
                                .font(.custom("Futura Medium", size: 11))
                                .tracking(-1)
                                .foregroundStyle(.brownPrimary)
                        }
                        .frame(minWidth: 130, alignment: .leading)
                }
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                Text(name)
                    .font(.custom("Futura Bold", size: 18))
                    .tracking(-1)
                    .foregroundStyle(Color.background)
            }
        }
    }
}

#Preview {
    CardActivtyhistory(image: "NailPump", name: "Pump", isDate: true, date: "21-12-2025")
}
