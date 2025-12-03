//
//  DurationSliderImage.swift
//  ZakFit
//
//  Created by Sebastien Besse on 02/12/2025.
//

import SwiftUI

struct DumbbellMotivationView: View {
    @Binding var sliderWidth: CGFloat
    @Binding var lastDragValue: CGFloat
    @Binding var sliderProgress: CGFloat
    
    let maxWidth: CGFloat
    let height: CGFloat = 80
    let stretchFactor: CGFloat = 1.3

    var body: some View {
        ZStack {
            GeometryReader { geo in
                // Remplissage
                Rectangle()
                    .foregroundStyle(.yellow)
                    .frame(width: sliderWidth * stretchFactor)
                    .position(
                        x: (sliderWidth * stretchFactor) / 2,
                        y: geo.size.height / 2
                    )
                    .clipped()
            }
            .mask {
                Image(systemName: "dumbbell.fill")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(x: stretchFactor, y: 1, anchor: .center)
            }

            // Outline
            Image(systemName: "dumbbell")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.black)
                .scaleEffect(x: stretchFactor, y: 1, anchor: .center)
        }
        .frame(width: maxWidth * stretchFactor, height: height)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    // On récupère la position x dans la vue
                    let newWidth = min(max(value.location.x / stretchFactor, 0), maxWidth)
                    sliderWidth = newWidth
                    sliderProgress = sliderWidth / maxWidth
                }
                .onEnded { _ in
                    lastDragValue = sliderWidth
                }
        )
        .animation(.easeOut(duration: 0.2), value: sliderWidth)
    }
}
#Preview {
    @Previewable @State var sliderWidth: CGFloat = 100
    @Previewable @State var lastDragValue: CGFloat = 0
    @Previewable @State var sliderProgress: CGFloat = 0

    VStack(spacing: 16) {
        DumbbellMotivationView(
            sliderWidth: $sliderWidth,
            lastDragValue: $lastDragValue,
            sliderProgress: $sliderProgress,
            maxWidth: 400
        )
        .frame(width: 400, height: 60)

        // Texte qui se met à jour en live
        Text("\(Int(sliderProgress * 100)) min")
            .font(.caption)
            .foregroundColor(.secondary)
    }
    .padding()
    .previewLayout(.sizeThatFits)
}
