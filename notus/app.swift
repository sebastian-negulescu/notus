//
//  notusApp.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-03-29.
//

import SwiftUI
import PencilKit

@main
struct NotusApp: App {
    @State var openBook: Book? = nil
    let library = Library()
    
    var body: some Scene {
        WindowGroup {
            if openBook == nil {
                LibraryView(book: $openBook, library: library)
            } else {
                DeskView(book: openBook!, library: library)
            }
        }
    }
}
