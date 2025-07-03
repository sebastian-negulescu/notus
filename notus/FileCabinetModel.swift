//
//  FileCabinetModel.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-07-01.
//

import Foundation
import PencilKit

class FileCabinet {
    var root: Folder
    var current_directory: Folder
    var path: [Int]
    var current_note: CabinetItem?
    
    init() {
        root = Folder(name: "")
        current_directory = root
        path = []
        current_note = nil
    }
    
    func select_item(name: String) -> CabinetItem {
        assert(Folder.name_exists(folder: current_directory, name: name))
        
        for (ind, cabinet_item) in current_directory.notes.enumerated() {
            if cabinet_item.name() == name {
                switch cabinet_item.item_type {
                case .Folder:
                    current_directory = cabinet_item.folder!
                    path.append(ind)
                case .NoteBook, .NotePad:
                    current_note = cabinet_item
                }
                return cabinet_item
            }
        }
        
        assert(false)
    }
    
    @discardableResult
    static func new_item(folder: Folder, name: String, item_type: CabinetItemType) -> Bool {
        let item = CabinetItem(item_type: item_type)
        switch item_type {
        case .Folder:
            item.folder = Folder(name: name, notes: [])
        case .NotePad:
            item.note_pad = NotePad(name: name, page: PKDrawing())
        case .NoteBook:
            item.note_book = NoteBook(name: name, pages: [PKDrawing()])
        }
        
        if Folder.name_exists(folder: folder, name: name) {
            return false
        }
        folder.notes.append(item)
        return true
    }
    
    func generate_path() -> String {
        var path_string: String = "/"
        var path_folder = root
        
        for ind in path {
            path_folder = path_folder.notes[ind].folder!
            path_string += path_folder.name + "/"
        }
        
        return path_string
    }
    
    func parent() -> Void {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
