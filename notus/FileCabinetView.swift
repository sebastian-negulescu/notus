//
//  NoteView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-03-29.
//

import SwiftUI

struct FileCabinetView: View {
    @State var file_cabinet: FileCabinet
    var on_file_select: () -> Void
    
    @StateObject var current_folder: Folder
    
    @State var creating_new_item: Bool = false
    
    func new_item() -> Void {
        creating_new_item = true
    }
    
    var columns = [
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20)
        ]
    
    var body: some View {
        HStack {
            Text(file_cabinet.generate_path())
                .padding(.leading)
            Spacer()
            Button(action: {}) {
                Text("preferences")
            }
            Button(action: new_item) {
                Text("new")
            }
            .padding(.trailing)
        }
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(current_folder.notes) { note in
                    VStack {
                        Image(systemName: "doc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text(note.name())
                    }
                    .padding()
                    .onTapGesture {
                        let item_type: CabinetItemType = file_cabinet.select_item(name: note.name()).item_type
                        if item_type != CabinetItemType.Folder {
                            on_file_select()
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $creating_new_item) {
            NewItemView(folder: current_folder)
        }
    }
}

#Preview {
    @Previewable @State var file_cabinet = FileCabinet()
    FileCabinetView(file_cabinet: file_cabinet, on_file_select: {_ = Screen.Desk}, current_folder: file_cabinet.current_directory)
}
