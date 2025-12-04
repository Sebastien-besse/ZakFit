//
//  VerticalCarousel.swift
//  ZakFit
//
//  Created by Sebastien Besse on 04/12/2025.
//

import SwiftUI

struct VerticalCarousel<Data: RandomAccessCollection, Content: View>: View
where Data.Element: Identifiable {

    private let itemsArray: [Data.Element]
    let content: (Data.Element) -> Content
    
    @State private var index: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    init(_ items: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.itemsArray = Array(items)
        self.content = content
    }
    
    var body: some View {
        ZStack {
            ForEach(visibleIndices(), id: \.self) { i in
                let item = itemsArray[i]
                
                content(item)
                    .offset(y: offset(i))
                    .rotation3DEffect(
                        angleForCard(i),
                        axis: (x: 1, y: 0, z: 0),
                        anchor: .center
                    )
                    .scaleEffect(i == index ? 1.05 : 0.9)
                    .opacity(i == index ? 1 : 0.4)
                    .zIndex(i == index ? 10 : 0)
                    .animation(.spring(response: 0.35, dampingFraction: 0.8), value: index)
            }
        }
        .frame(height: 200)
        .gesture(
            DragGesture()
                .updating($dragOffset) { value, state, _ in
                    state = value.translation.height
                }
                .onEnded { value in
                    if value.translation.height < -50 { moveDown() }
                    else if value.translation.height > 50 { moveUp() }
                }
        )
    }
    
    // ——————————————————————————
    // 2 cartes visibles
    // ——————————————————————————
    private func visibleIndices() -> [Int] {
        let previous = (index - 1 + itemsArray.count) % itemsArray.count
        return [previous, index]
    }

    // ——————————————————————————
    // LIMITATION DU DRAG : ±80 px max
    // ——————————————————————————
    private var limitedDragOffset: CGFloat {
        max(min(dragOffset, 80), -80)
    }

    private func offset(_ i: Int) -> CGFloat {
        if i == index {
            return limitedDragOffset
        } else {
            return -20
        }
    }

    // ——————————————————————————
    // Rotation 3D limitée aussi
    // ——————————————————————————
    private func angleForCard(_ i: Int) -> Angle {
        guard i == index else { return .degrees(0) }
        
        let normalized = limitedDragOffset / 80
        return .degrees(Double(normalized * -10))
    }
    
    private func moveUp() {
        index = (index - 1 + itemsArray.count) % itemsArray.count
    }
    
    private func moveDown() {
        index = (index + 1) % itemsArray.count
    }
}
