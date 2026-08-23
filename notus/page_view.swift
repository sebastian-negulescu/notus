//
//  PageView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-03-12.
//

import SwiftUI
import PencilKit

struct PageView: View {
    let drawing: DrawingView
    
    init(page: Page) {
        self.drawing = DrawingView(drawing: page.drawing)
    }
    
    var body: some View {
        ZStack {
            drawing
        }
    }
}

struct DrawingView: UIViewRepresentable {
    let drawing: PKDrawing
    let canvas = PKCanvasView()
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawing = drawing
        canvas.drawingPolicy = .anyInput
        canvas.tool = PKInkingTool(.pen, color: .black, width: 10)
        // TODO: set up delegate to save drawing as it's stroked
        
        return canvas
    }
    
    func updateUIView(_ type: PKCanvasView, context: Context) {
        // TODO: mark drawing as modified
    }
    
    static func dismantleUIView(uiView: PKCanvasView, coordinator: ()) {
        // TODO: save drawing
    }
}

#Preview {
    PageView(page: Page(name: "", id: UUID(), drawing: PKDrawing()))
}
