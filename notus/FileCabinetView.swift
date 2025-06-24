//
//  NoteView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-03-29.
//

import SwiftUI

struct FileCabinetView: View {
    var file_cabinet: FileCabinet
    var on_file_select: () -> Void
    
    func test_new_file() -> Void {
        file_cabinet.new_item(name: "test", item_type: CabinetItems.NotePad)
        file_cabinet.select_item(name:"test")
        on_file_select()
    }
    
    var columns = [
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20)
        ]
    
    var body: some View {
        HStack {
            Text("/test/path")
            Button(action: {}) {
                Text("preferences")
            }
            Button(action: test_new_file) {
                Text("new")
            }
        }
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(file_cabinet.current_directory.notes) { note in
                    VStack {
                        Image(systemName: "doc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text(note.name())
                    }
                    .padding()
                    .onTapGesture {
                        // TODO: select file
                        file_cabinet.select_item(name: note.name())
                        on_file_select()
                    }
                }
            }
        }
    }
}

#Preview {
    FileCabinetView(file_cabinet: FileCabinet(), on_file_select: {_ = Screen.Desk})
}
