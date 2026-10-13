//
//  library.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-08-16.
//

import Foundation
import PencilKit

protocol IdentifiableResource: Identifiable {
    var name: String { get set }
    var id: UUID { get }
}

struct Page: IdentifiableResource, Codable {
    var name: String
    let id: UUID
    var drawing: PKDrawing
    var background: Int
    
    static func newPage() -> Page {
        return Page(name: "New Page", id: UUID(), drawing: PKDrawing(), background: 0)
    }
}

struct Book: IdentifiableResource, Codable {
    var name: String
    let id: UUID
    var pages: [Page]
    var openPage: Int
    
    static func newBook(num_pages: Int) -> Book {
        return Book(
            name: "New Book",
            id: UUID(),
            pages: (0..<num_pages).map{_ in Page.newPage()},
            openPage: 0
        )
    }
}

class Library {
    private let fileManager = FileManager.default
    
    func checkOut(id: UUID) throws -> Book {
        let url = URL.documentsDirectory.appendingPathComponent(id.uuidString)
        let data = try Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try decoder.decode(Book.self, from: data)
    }
    
    func checkIn(book: Book) throws {
        let url = URL.documentsDirectory.appendingPathComponent(book.id.uuidString)
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .binary
        let data = try encoder.encode(book)
        try data.write(to: url, options: .atomic)
    }
    
    func updatePage(id: UUID, pageNumber: Int, drawing: PKDrawing) throws {
        var book = try checkOut(id: id)
        book.pages[pageNumber].drawing = drawing
        book.openPage = pageNumber
        try checkIn(book: book)
    }
    
    func catalog() -> [URL] {
        do {
            return try fileManager.contentsOfDirectory(at: URL.documentsDirectory, includingPropertiesForKeys: nil)
        } catch {
            return []
        }
    }
}
