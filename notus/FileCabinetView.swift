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
    
    @State var creating_new_item: Bool = false
    @State var fetch_items: Bool = false
    
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
            Text(file_cabinet.open_folder.absoluteString)
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
                ForEach(file_cabinet.read_folder() ?? [], id: \.self) { note in
                    VStack {
                        Image(systemName: "doc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text(note)
                    }
                    .padding()
                    .onTapGesture {
                    }
                }
            }
        }
        .sheet(isPresented: $creating_new_item, onDismiss: {
            fetch_items = false
        }) {
            NewItemView(file_cabinet: file_cabinet, on_create: {fetch_items = true})
        }
    }
}

#Preview {
    @Previewable @State var file_cabinet = FileCabinet()
    FileCabinetView(file_cabinet: file_cabinet, on_file_select: {_ = Screen.Desk})
}
