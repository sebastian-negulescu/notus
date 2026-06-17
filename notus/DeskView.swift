//
//  CanvasView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-06-15.
//

import SwiftUI
import PencilKit



struct DeskView: View {
    @State var background = BackgroundInfo(spacing: 30,
                                           weight: 1,
                                           raw_colour: 0,
                                           raw_pattern: 0)

    var body: some View {
        ZStack(alignment: .topTrailing) {
            PageView(drawing: PKDrawing(), background: $background)
            TabStackView(background: $background)
        }
    }
}

#Preview {
    DeskView()
}
