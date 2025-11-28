//
//  AuthView.swift
//  ZakFit
//
//  Created by Sebastien Besse on 28/11/2025.
//

import SwiftUI

struct AuthView: View {
    var body: some View {
        VStack{
            Image("NailAuth")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
            Text("ICI POUR ÊTRE MEILLIEUR")
                .font(.custom("Futura Condensed ExtraBold", size: 64)).tracking(-5)
        }
        
    }
}

#Preview {
    AuthView()
}
