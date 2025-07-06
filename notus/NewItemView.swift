//
//  NewItemView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-07-01.
//

import SwiftUI

struct NewItemView: View {
    @State var file_cabinet: FileCabinet
    
    @Environment(\.dismiss) var dismiss
    
    @State private var selected_item: String = ""
    private let item_options = ["folder", "note"]
    
    @State private var item_name: String = ""
    
    private func create_item() -> Bool {
        switch selected_item {
        case "folder":
            return file_cabinet.create_folder(name: item_name)
        case "note":
            return file_cabinet.create_note(name: item_name)
        default:
            return false
        }
    }
    
    var body: some View {
        VStack() {
            HStack() {
                Button("close") {
                    dismiss()
                }
                .padding([.top, .leading])
                Spacer()
                Button("create") {
                    if create_item() {
                        dismiss()
                    }
                }
                .padding([.top, .trailing])
            }
            Spacer()
            VStack(alignment: .leading) {
                ForEach(item_options, id: \.self) { option in
                    HStack {
                        Image(systemName: selected_item == option ? "largecircle.fill.circle" : "circle")
                            .foregroundColor(.blue)
                        Text(option)
                        Spacer()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selected_item = option
                    }
                    .padding(.vertical, 5)
                }
            }
            .padding([.leading, .trailing])
            VStack(alignment: .leading) {
                TextField("name", text: $item_name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)

            }
            .padding([.leading, .trailing])
        }
    }
}

#Preview {
    NewItemView(file_cabinet: FileCabinet())
}
