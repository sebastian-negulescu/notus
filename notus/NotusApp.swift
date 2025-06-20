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
    @State private var file_cabinet: FileCabinet = FileCabinet()
    
    var body: some Scene {
        WindowGroup {
            switch screen {
            case .FileCabinet:
                FileCabinetView(on_file_select: {screen = .Desk}, file_cabinet: file_cabinet)
            case .Desk:
                DeskView(on_file_away: {screen = .FileCabinet})
            }
        }
    }
}
