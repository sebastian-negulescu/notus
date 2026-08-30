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
    let library: Library
    
    var body: some View {
        Button(action: make_book) {
            Text("Make Book")
        }
        VStack {
            ForEach(library.catalog(), id: \.self) { path in
                Button(action: {() -> Void in
                    let uuid = UUID(uuidString: path.lastPathComponent)
                    if uuid == nil { return }
                    do {
                        book = try library.checkOut(id: uuid!)
                    } catch {
                        book = nil
                    }
                }){ Text(path.lastPathComponent) }
            }
        }
    }
    
    func make_book() {
        book = Book.newBook(num_pages: 10)
        do {
            try library.checkIn(book: book!)
        } catch {}
    }
}

#Preview {
    @Previewable @State var book: Book? = nil
    LibraryView(book: $book, library: Library())
}
