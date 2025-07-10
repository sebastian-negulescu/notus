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
    @State private var screen: Screen = Screen.FileCabinet
    private let file_cabinet: FileCabinet = FileCabinet()
    
    var body: some Scene {
        WindowGroup {
            switch screen {
            case .FileCabinet:
                FileCabinetView(file_cabinet: file_cabinet, on_note_select: {screen = .Desk})
            case .Desk:
                DeskView(file_cabinet: file_cabinet, on_file_away: {screen = .FileCabinet})
            }
        }
    }
}
