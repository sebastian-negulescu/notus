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
        self.page = PageView(drawing: PKDrawing(), background: BackgroundInfo(spacing: 30, weight: 0.1, background_colour: .white, pattern_colour: .black, pattern: .Iso))
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            page
            TabStackView()
        }
    }
}

#Preview {
    DeskView()
}
