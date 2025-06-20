//
//  NoteView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-03-29.
//

import SwiftUI

struct FileCabinetView: View {
    var on_file_select: () -> Void
    var file_cabinet: FileCabinet
    
    @State private var files: [URL] = []
    @State private var path: [String] = []
    
    func test_new_file() -> Void {
        file_cabinet.new_item(path: path, name: "test", item_type: CabinetItems.NotePad)
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
            Text(path.joined(separator:"/"))
            Button(action: {}) {
                Text("preferences")
            }
            Button(action: test_new_file) {
                Text("new")
            }
        }
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(files, id: \.self) { file in
                    VStack {
                        Image(systemName: "doc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text(file.lastPathComponent)
                    }
                    .padding()
                    .onTapGesture {
                        // TODO: select file
                        
                    }
                }
            }
        }
    }
}

#Preview {
    FileCabinetView(on_file_select: {_ = Screen.Desk})
}
