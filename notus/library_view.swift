//
//  library_view.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-08-22.
//

import SwiftUI
import PencilKit

struct LibraryView: View {
    @Binding var book: Book?
    let library = Library()
    
    var body: some View {
        Button(action: makeBook) {
            Text("Make Book")
        }
        Text(library.catalog().map{ $0.lastPathComponent }.joined(separator: "\n"))
    }
    
    func makeBook() {
        book = Book.newBook(num_pages: 10)
        do {
            try library.checkin(book: book!)
        } catch {}
    }
}

#Preview {
    @Previewable @State var book: Book? = nil
    LibraryView(book: $book)
}
