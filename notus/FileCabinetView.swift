//
//  NoteView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-03-29.
//

import SwiftUI

struct FileCabinetView: View {
    let file_cabinet: FileCabinet
    let on_note_select: () -> Void
    
    @State private var item_names: [String]
    
    init(file_cabinet: FileCabinet, on_note_select: @escaping () -> Void) {
        self.file_cabinet = file_cabinet
        self.on_note_select = on_note_select
        item_names = file_cabinet.read_folder() ?? []
    }
    
    @State private var creating_new_item: Bool = false
    func new_item() -> Void {
        creating_new_item = true
    }
    
    var columns = [
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20)
        ]
    
    var body: some View {
        HStack {
            Text(file_cabinet.open_folder.absoluteString)
                .padding(.leading)
            Spacer()
            Button(action: {}) {
                Text("preferences")
            }
            .buttonStyle(.bordered)
            Button(action: new_item) {
                Text("new")
            }
            .buttonStyle(.bordered)
            .padding(.trailing)
        }
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(item_names, id: \.self) { note in
                    VStack {
                        Image(systemName: "doc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text(note)
                    }
                    .padding()
                    .onTapGesture {
                        if file_cabinet.item_type(name: note) == CabinetItems.note {
                            file_cabinet.desk = file_cabinet.read_note(name: note)
                            on_note_select()
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $creating_new_item, onDismiss: {
            item_names = file_cabinet.read_folder() ?? []
        }) {
            NewItemView(file_cabinet: file_cabinet)
        }
    }
}

#Preview {
    @Previewable @State var file_cabinet = FileCabinet()
    FileCabinetView(file_cabinet: file_cabinet, on_note_select: {_ = Screen.Desk})
}
