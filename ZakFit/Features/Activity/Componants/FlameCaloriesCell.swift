//
//  FlameCaloriesCell.swift
//  ZakFit
//
//  Created by Sebastien Besse on 03/12/2025.
//

import SwiftUI

struct FlameCaloriesCell: View {
    @Binding var fillHeight: CGFloat
    @Binding var lastDragValue: CGFloat
    @Binding var progress: CGFloat
    
    let maxHeight: CGFloat
    
    var body: some View {
        ZStack {
            
            GeometryReader { geo in
                Rectangle()
                    .foregroundStyle(.orange)
                    .frame(height: fillHeight)
                    .position(
                        x: geo.size.width / 2,
                        y: geo.size.height - (fillHeight / 2)
                    )
                    .clipped()
            }
            .mask {
                Image(systemName: "flame.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Image(systemName: "flame")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.black)
        }
        .frame(height: maxHeight)
        .scaledToFit()
        .gesture(
            DragGesture()
                .onChanged { value in
                    
                    let newHeight = -value.translation.height + lastDragValue
                    
                    var h = newHeight
                    h = h > maxHeight ? maxHeight : h
                    h = h < 0 ? 0 : h
                    
                    fillHeight = h
                    progress = h / maxHeight
                }
                .onEnded { _ in
                    lastDragValue = fillHeight
                    
                    fillHeight = fillHeight > maxHeight ? maxHeight : fillHeight
                    fillHeight = fillHeight < 0 ? 0 : fillHeight
                    
                    progress = fillHeight / maxHeight
                }
        )
        .animation(.easeOut(duration: 0.2), value: fillHeight)
    }
}

#Preview {
    @Previewable @State var fillHeight: CGFloat = 100
    @Previewable @State var lastDrag: CGFloat = 0
    @Previewable @State var progress: CGFloat = 0.4

    VStack(spacing: 16) {
        FlameCaloriesCell(
            fillHeight: $fillHeight,
            lastDragValue: $lastDrag,
            progress: $progress,
            maxHeight: 250
        )
        .frame(width: 120, height: 250)
        .padding()

        
        Text("\(Int(progress * 1000)) kcal")
            .font(.caption)
            .foregroundColor(.secondary)
    }
    .padding()
    .previewLayout(.sizeThatFits)
}
