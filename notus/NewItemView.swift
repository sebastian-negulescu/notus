//
//  NewItemView.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-07-01.
//

import SwiftUI

struct NewItemView: View {
    @ObservedObject var folder: Folder
    
    @Environment(\.dismiss) var dismiss
    
    @State private var selected_item: String = ""
    private let item_options = ["folder", "notepad", "notebook"]
    
    @State private var item_name: String = ""
    
    private func create_item() -> Bool {
        let item_type: CabinetItemType = CabinetItemType.get_item_type(item_type: selected_item)
        return FileCabinet.new_item(folder: folder, name: item_name, item_type: item_type)
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
    @Previewable @StateObject var folder = Folder(name: "")
    NewItemView(folder: folder)
}
