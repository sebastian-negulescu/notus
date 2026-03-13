//
//  CanvasView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-06-15.
//

import SwiftUI
import PencilKit

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

struct DeskView: View {
    var page: PageView
    
    init() {
        self.page = PageView(drawing: PKDrawing())
    }
    
    @State var tab_x: CGFloat = 0
    @State var tab_offset: CGSize = .zero
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            page
            TabView(colour: .red, content: Text("Hello, world!"))
                .offset(x: (500 + (tab_offset.width + tab_x)).clamped(to: CGFloat(0)...CGFloat(500)))
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            tab_offset = gesture.translation
                        }
                        .onEnded { gesture in
                            tab_x += gesture.translation.width
                            tab_offset = .zero
                        }
                )
            TabView(colour: .green, content: Text("Goodbye, world!"))
                .offset(x: 500, y: 50)
            TabView(colour: .blue, content: Text("Goodbye, world!"))
                .offset(x: 500, y: 100)
        }
    }
}

#Preview {
    DeskView()
}
