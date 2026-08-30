//
//  notusTests.swift
//  notusTests
//
//  Created by Sebastian Negulescu on 2025-03-29.
//

import Testing
import PencilKit
@testable import notus

@Suite("library") struct notusLibraryTests {
    @Test func testBook() throws {
        let book = Book(name: "test", id: UUID(), pages: [])
        let library = Library()
        try library.putBook(book: book)
        let _ = try library.getBook(id: book.id)
    }
}
