//
//  CanvasView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-06-15.
//

import SwiftUI
import PencilKit

struct NoteView: UIViewRepresentable {
    let canvas = PKCanvasView()
    let tool_picker = PKToolPicker()
    
    func makeUIView(context: Context) -> UIViewType {
        canvas.drawingPolicy = .pencilOnly
        canvas.tool = PKInkingTool(.pen, color: .black, width: 10)

        canvas.becomeFirstResponder()

        tool_picker.addObserver(canvas)
        setToolPickerVisibility(visible: true)
        
        return canvas
    }
    
    func updateUIView(_ type: UIViewType, context: Context) {
        // TODO: mark drawing as modified
    }
    
    static func dismantleUIView(uiView: UIViewType, coordinator: ()) {
        // TODO: save drawing
    }
    
    func setToolPickerVisibility(visible: Bool) {
        tool_picker.setVisible(visible, forFirstResponder: canvas)
    }
    
    typealias UIViewType = PKCanvasView
}

struct DeskView: View {
    var on_file_away: () -> Void
    
    func file_away() -> Void {
        note.setToolPickerVisibility(visible: false)
        on_file_away()
    }
    
    let note = NoteView()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            note
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
