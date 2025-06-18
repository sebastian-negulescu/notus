//
//  CanvasView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-06-15.
//

import SwiftUI
import PencilKit

struct NoteView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIViewType {
        let note_canvas = PKCanvasView()
        note_canvas.drawingPolicy = .pencilOnly
        note_canvas.tool = PKInkingTool(.pen, color: .black, width: 10)
        
        let tool_picker = PKToolPicker()
        tool_picker.addObserver(note_canvas)
        tool_picker.setVisible(true, forFirstResponder: note_canvas)
        
        return note_canvas
    }
    
    func updateUIView(_ type: UIViewType, context: Context) {
        
    }
    
    static func dismantleUIView(_ uiView: PKCanvasView, coordinator: ()) {
        
    }
    
    typealias UIViewType = PKCanvasView
}

struct DeskView: View {
    var on_file_away: () -> Void
    
    var body: some View {
        NoteView()
    }
}

#Preview {
    DeskView(on_file_away: {_ = Screen.FileCabinet})
}
