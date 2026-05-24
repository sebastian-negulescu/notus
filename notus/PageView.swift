//
//  PageView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-03-12.
//

import SwiftUI
import PencilKit

struct PageView: View {
    let wrapped_drawing: DrawingView
    let background_info: BackgroundInfo
    
    init(drawing: PKDrawing, background: BackgroundInfo) {
        self.wrapped_drawing = DrawingView(drawing: drawing)
        self.background_info = background
    }
    
    var body: some View {
        ZStack {
            wrapped_drawing
            Canvas { context, size in
                fill_background(&context, size, background_info: background_info)
            }
        }
    }
}

struct DrawingView: UIViewRepresentable {
    let drawing: PKDrawing
    let canvas = PKCanvasView()
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawing = drawing
        canvas.drawingPolicy = .pencilOnly
        canvas.tool = PKInkingTool(.pen, color: .black, width: 10)
        canvas.becomeFirstResponder()
        
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
    PageView(drawing: PKDrawing(),
             background: BackgroundInfo(spacing: 30, weight: 3, background_colour: .white, pattern_colour: .black, pattern: .Iso))
}
