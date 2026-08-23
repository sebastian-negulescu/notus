//
//  CanvasView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-06-15.
//

import SwiftUI
import PencilKit

struct DeskView: View {
    @State var book: Book

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // TODO: swiping changes the page
            PageView(page: book.pages[0])
        }
    }
}

#Preview {
    DeskView(book: Book(name: "", id: UUID(), pages: [Page(name: "", id: UUID(), drawing: PKDrawing())]))
}
