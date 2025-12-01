//
//  HeightView.swift
//  ZakFit
//
//  Created by apprenant152 on 01/12/2025.
//

import SwiftUI

struct HeightView: View {
    @Environment(RegisterViewModel.self) var vm
    
    @State private var height: Double = 175
    @State private var dragOffset: CGFloat = 0
    let minHeight: Double = 140
    let maxHeight: Double = 220
    
    var body: some View {
            VStack(spacing: 0) {
                // Titre
                Text("Ta taille ?")
                    .font(.custom("Futura Condensed ExtraBold", size: 40))
                    .tracking(-3)
                    .foregroundStyle(.brownPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                Text("Taille en cm. Ne t'inquiéte pas, tu pourras toujours la modifier plus tard")
                    .font(.custom("Futura", size: 14))
                    .foregroundStyle(.brownPrimary.opacity(0.4))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                ZStack {
                    // Liste de chiffres scrollable
                    ScrollViewReader { proxy in
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 0) {
                                ForEach(Int(minHeight)...Int(maxHeight), id: \.self) { value in
                                    Text("\(value)")
                                        .font(.custom("Futura Condensed ExtraBold", size: getFontSize(for: value)))
                                        .foregroundColor(getColor(for: value))
                                        .frame(height: 60)
                                        .id(value)
                                        .padding(4)
                                }
                            }
                            .padding(.vertical, 120)
                        }
                        .frame(height: 300)
                        .simultaneousGesture(
                            DragGesture()
                                .onChanged { _ in }
                        )
                        .onAppear {
                            proxy.scrollTo(Int(height), anchor: .center)
                        }
                        .onChange(of: height) { newValue in
                            withAnimation(.spring(response: 0.3)) {
                                proxy.scrollTo(Int(newValue), anchor: .center)
                            }
                        }
                    }
                    
                    // Barres de sélection
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.brownPrimary.opacity(0.8))
                            .frame(width: 140, height: 8)
                        
                        Spacer()
                            .frame(height: 60)
                        
                        Rectangle()
                            .fill(Color.brownPrimary.opacity(0.8))
                            .frame(width: 140, height: 8)
                    }
                    .frame(height: 60)
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
                                        let delta = -value.translation.height / 60
                                        let newHeight = 175 + delta
                                        height = min(max(newHeight, minHeight), maxHeight)
                                    }
                                    .onEnded { _ in
                                        height = round(height)
                                    }
                            )
                    }
                )
                .padding(60)
                
         
                
  
            }
        
    }
    
    func getFontSize(for value: Int) -> CGFloat {
        let distance = abs(Double(value) - height)
        if distance == 0 {
            return 56
        } else if distance == 1 {
            return 36
        } else if distance == 2 {
            return 24
        } else {
            return 18
        }
    }
    
    func getColor(for value: Int) -> Color {
        let distance = abs(Double(value) - height)
        if distance == 0 {
            return .pinkPrimary
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
    HeightView()
        .environment(RegisterViewModel())
}



