//
//  PageView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-03-12.
//

import SwiftUI
import PencilKit

struct PageView: UIViewRepresentable {
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
