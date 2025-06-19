//
//  CanvasView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-06-15.
//

import SwiftUI
import PencilKit

struct NoteView: UIViewRepresentable {
    let tool_picker = PKToolPicker()
    
    func makeUIView(context: Context) -> UIViewType {
        let canvas = PKCanvasView()
        canvas.drawingPolicy = .pencilOnly
        canvas.tool = PKInkingTool(.pen, color: .black, width: 10)
        
        tool_picker.addObserver(canvas)
        tool_picker.setVisible(true, forFirstResponder: canvas)
        
        canvas.becomeFirstResponder()
        
        return canvas
    }
    
    func updateUIView(_ type: UIViewType, context: Context) {
        // TODO: mark drawing as modified
    }
    
    static func dismantleUIView(_ uiView: UIViewType, coordinator: ()) {
        // TODO: save drawing
    }
    
    typealias UIViewType = PKCanvasView
}

struct DeskView: View {
    var on_file_away: () -> Void
    
    func file_away() -> Void {
        
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            NoteView()
            Button(action: file_away) {
                Text("file away")
            }
            .buttonStyle(.bordered)
            .padding(.trailing, 10)
        }
    }
}

#Preview {
    DeskView(on_file_away: {_ = Screen.FileCabinet})
}
