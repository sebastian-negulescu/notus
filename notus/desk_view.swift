//
//  CanvasView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-06-15.
//

import SwiftUI
import PencilKit

struct DeskView: View {
    let library: Library
    let drawingView: DrawingView
    
    init(book: Book, library: Library) {
        self.library = library
        self.drawingView = DrawingView(
            drawing: book.pages[0].drawing,
            save: { (drawing: PKDrawing) -> Bool in
                do {
                    try library.updatePage(id: book.id, pageNumber: 0, drawing: drawing)
                    return true
                } catch {}
                return false
            })
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // TODO: swiping changes the page
            drawingView
        }
    }
}

struct DrawingView: UIViewRepresentable {
    let canvas: PKCanvasView
    let delegate: PKCanvasViewDelegate
    
    init(drawing: PKDrawing, save: @escaping (PKDrawing) -> Bool) {
        delegate = DrawingViewDelegate(save: save)
        
        canvas = PKCanvasView()
        canvas.drawing = drawing
        canvas.tool = PKInkingTool(.pen, color: .black, width: 10)
        canvas.drawingPolicy = .anyInput
        canvas.delegate = delegate
    }
    
    func makeUIView(context: Context) -> PKCanvasView {
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

#Preview {
    DeskView(book: Book.newBook(num_pages: 1), library: Library())
}
