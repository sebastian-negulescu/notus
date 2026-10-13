//
//  drawing_view.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-10-11.
//

import SwiftUI
import PencilKit

struct DrawingView: UIViewRepresentable {
    let drawing: PKDrawing
    let delegate: PKCanvasViewDelegate
    
    init(drawing: PKDrawing, save: @escaping (PKDrawing) -> Bool) {
        self.drawing = drawing
        delegate = DrawingViewDelegate(save: save)
    }
    
    static func newDrawingView(book: Book, library: Library, pageNumber: Int) -> DrawingView {
        return DrawingView(
            drawing: book.pages[pageNumber].drawing,
            save: { (drawing: PKDrawing) -> Bool in
                do {
                    try library.updatePage(id: book.id, pageNumber: pageNumber, drawing: drawing)
                    return true
                } catch {}
                return false
            }
        )
    }
    
    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        
        canvas.drawing = drawing
        canvas.tool = PKInkingTool(.pen, color: .black, width: 10)
        canvas.drawingPolicy = .pencilOnly
        
        canvas.isScrollEnabled = false
        canvas.panGestureRecognizer.isEnabled = false
        
        canvas.isOpaque = false
        canvas.backgroundColor = .clear

        canvas.delegate = delegate
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}

class DrawingViewDelegate: NSObject, PKCanvasViewDelegate {
    let save: (PKDrawing) -> Bool
    init(save: @escaping (PKDrawing) -> Bool) {
        self.save = save
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        let _ = save(canvasView.drawing)
    }
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {}
    func canvasViewSelectionDidChange(_ canvasView: PKCanvasView) {}
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {}
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {}
}
