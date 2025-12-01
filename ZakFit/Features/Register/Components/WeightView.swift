//
//  WeightView.swift
//  ZakFit
//
//  Created by apprenant152 on 01/12/2025.
//

import SwiftUI

struct WeightView: View {
    @State private var weight: Double = 70
    @State private var dragOffset: CGFloat = 0
    let minWeight: Double = 40
    let maxWeight: Double = 150
    
    var body: some View {

            VStack(spacing: 0) {
               
                // Titre
                Text("Ton poids ?")
                    .font(.custom("Futura Condensed ExtraBold", size: 40))
                    .tracking(-3)
                    .foregroundColor(.brownPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                // Sous-titre
                Text("Poid en Kg. Ne t'inquiéte pas, tu pourras toujours le modifier plus tard")
                    .font(.custom("Futura", size: 14))
                    .foregroundStyle(.brownPrimary.opacity(0.4))
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                
                // Picker horizontal style iOS
                ZStack {
                    // Liste de chiffres horizontale
                    ScrollViewReader { proxy in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(Int(minWeight)...Int(maxWeight), id: \.self) { value in
                                    Text("\(value)")
                                        .font(.custom("Futura Condensed ExtraBold", size: getFontSize(for: value)))
                                        
                                        .foregroundColor(getColor(for: value))
                                        .frame(width: 80)
                                        .id(value)
                                }
                            }
                            .padding(.horizontal, UIScreen.main.bounds.width / 2 - 40)
                        }
                        .frame(height: 120)
                        .simultaneousGesture(
                            DragGesture()
                                .onChanged { _ in }
                        )
                        .onAppear {
                            proxy.scrollTo(Int(weight), anchor: .center)
                        }
                        .onChange(of: weight) { newValue in
                            withAnimation(.spring(response: 0.3)) {
                                proxy.scrollTo(Int(newValue), anchor: .center)
                            }
                        }
                    }
                    
                    // Triangle indicateur en dessous
                    VStack {
                        Spacer()
                        Image(systemName: "triangle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.yellowPrimary)
                            .offset(y: 10)
                    }
                    .frame(height: 120)
                    .allowsHitTesting(false)
                }
                .overlay(
                    // Zone de capture des gestes
                    GeometryReader { geometry in
                        Color.clear
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        let delta = -value.translation.width / 80
                                        let newWeight = 70 + delta
                                        weight = min(max(newWeight, minWeight), maxWeight)
                                    }
                                    .onEnded { _ in
                                        weight = round(weight)
                                    }
                            )
                    }
                )
                .padding(.bottom, 60)
                
                Spacer()
                
            }
        
    }
    
    func getFontSize(for value: Int) -> CGFloat {
        let distance = abs(Double(value) - weight)
        if distance == 0 {
            return 58
        } else if distance == 1 {
            return 32
        } else if distance == 2 {
            return 18
        } else {
            return 20
        }
    }
    
    func getWeight(for value: Int) -> Font.Weight {
        let distance = abs(Double(value) - weight)
        return distance == 0 ? .bold : .regular
    }
    
    func getColor(for value: Int) -> Color {
        let distance = abs(Double(value) - weight)
        if distance == 0 {
            return .yellow
        } else if distance == 1 {
            return .brownPrimary
        } else if distance == 2 {
            return .brownPrimary.opacity(0.6)
        } else {
            return .brownPrimary.opacity(0.3)
        }
    }
}

#Preview {
    WeightView()
}
