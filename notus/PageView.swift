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
    @Binding var background: BackgroundInfo
    
    init(drawing: PKDrawing, background: Binding<BackgroundInfo>) {
        self.drawing = DrawingView(drawing: drawing)
        self._background = background
    }
    
    var body: some View {
        ZStack {
            drawing
            Canvas { context, size in
                fill_background(&context, size, info: background)
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
    @Previewable @State var background = BackgroundInfo(spacing: 30,
                                           weight: 1,
                                           raw_colour: 0,
                                           raw_pattern: 0)
    PageView(drawing: PKDrawing(), background: $background)
}
