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
    
    var body: some Scene {
        WindowGroup {
            if openBook == nil {
                LibraryView(book: $openBook)
            } else {
                DeskView(book: openBook!)
            }
        }
    }
}
