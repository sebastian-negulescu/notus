//
//  notusApp.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-03-29.
//

import SwiftUI

@main
struct NotusApp: App {
    @State private var screen: Screen = Screen.Desk
    
    var body: some Scene {
        WindowGroup {
            switch screen {
            case .FileCabinet:
                FileCabinetView(on_file_select: {screen = .Desk})
            case .Desk:
                DeskView(on_file_away: {screen = .FileCabinet})
            }
        }
    }
}
