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
    let library: Library
    
    init(book: Book, library: Library) {
        self.book = book
        self.library = library
    }

    var body: some View {
        ViewTutorialPageViewController()
    }
}

/*
 #Preview {
 DeskView(book: newColouringBook(), library: Library())
 }
 */
