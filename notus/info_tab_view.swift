//
//  info_tab_view.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-05-15.
//

import SwiftUI
import System

struct InfoTabView: View {
    let tab_offset: UInt
    
    init(tab_offset: UInt) {
        self.tab_offset = tab_offset
        
        self.date_formatter.dateFormat = "dd-MM-YYYY"
    }
    
    let name: String = "Placeholder"
    let location: FilePath = "/path/to/Placeholder"
    let date_created: Date = Date()
    let date_formatter = DateFormatter()
    
    var content: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.largeTitle)
                    .fontDesign(.serif)
                Text(location.string)
                Text(date_formatter.string(from: date_created))
                
                Spacer()
                
                HStack {
                    Button(action: do_nothing) {
                        Label("File away", systemImage: "arrowshape.turn.up.backward")
                    }
                    .buttonStyle(.bordered)
                    Button(action: do_nothing) {
                        Label("Export", systemImage: "tray.and.arrow.up")
                    }
                    .buttonStyle(.bordered)
                    Button(action: do_nothing) {
                        Label("Delete", systemImage: "trash")
                            .foregroundStyle(.red)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(.all, 20)
            Spacer()
        }
    }
    
    var body: some View {
        TabView(tab_offset: self.tab_offset, colour: .red, content: content)
    }
}
