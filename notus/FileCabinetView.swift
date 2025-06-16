//
//  NoteView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-03-29.
//

import SwiftUI

struct FileCabinetView: View {
    var on_file_select: () -> Void
    
    @State private var files: [URL] = []
    
    var columns = [
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20)
        ]
    
    var body: some View {
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
