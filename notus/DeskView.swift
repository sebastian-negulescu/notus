//
//  CanvasView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-06-15.
//

import SwiftUI
import PencilKit



struct DeskView: View {
    var page: PageView
    
    init() {
        self.page = PageView(drawing: PKDrawing())
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            page
            TabView(tab_offset: 0, colour: .red, content: Text("Hello, world!"))
            TabView(tab_offset: 1, colour: .green, content: Text("Hello, world!"))
            TabView(tab_offset: 2, colour: .blue, content: Text("Hello, world!"))
        }
    }
}

#Preview {
    DeskView()
}
