//
//  NoteModel.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-06-19.
//

import Foundation
import PencilKit

enum CabinetItems {
    case Folder
    case NoteBook
    case NotePad
}

class CabinetItem : Identifiable {
    var item_type: CabinetItems
    var note_book: NoteBook?
    var note_pad: NotePad?
    var folder: Folder?
    
    func name() -> String {
        switch item_type {
        case .Folder:
            return folder!.name
        case .NotePad:
            return note_pad!.name
        case .NoteBook:
            return note_book!.name
        }
    }
    
    init(item_type: CabinetItems) {
        self.item_type = item_type
    }
}

struct NoteBook {
    var name: String
    var pages: [PKDrawing]
}

struct NotePad {
    var name: String
    var page: PKDrawing
}

class Folder {
    var name: String
    var notes: [CabinetItem]
    
    init(name: String) {
        self.name = name
        notes = []
    }
    
    init(name: String, notes: [CabinetItem]) {
        self.name = name
        self.notes = notes
    }
    
    static func name_exists(folder: Folder, name: String) -> Bool {
        for note in folder.notes {
            if note.name() == name {
                return true
            }
        }
        return false
    }
}

class FileCabinet {
    var root: Folder = Folder(name: "")
    
    var current_directory: Folder
    var current_note: CabinetItem? = nil
    
    init() {
        current_directory = root
    }
    
    func select_item(name: String) -> CabinetItem {
        assert(Folder.name_exists(folder: current_directory, name: name))
        
        for cabinet_item in current_directory.notes {
            if cabinet_item.name() == name {
                switch cabinet_item.item_type {
                case .Folder:
                    current_directory = cabinet_item.folder!
                case .NoteBook, .NotePad:
                    current_note = cabinet_item
                }
                return cabinet_item
            }
        }
        
        assert(false)
    }
    
    func new_item(name: String, item_type: CabinetItems) -> Bool {
        let item = CabinetItem(item_type: item_type)
        switch item_type {
        case .Folder:
            item.folder = Folder(name: name, notes: [])
        case .NotePad:
            item.note_pad = NotePad(name: name, page: PKDrawing())
        case .NoteBook:
            item.note_book = NoteBook(name: name, pages: [PKDrawing()])
        }
        
        if Folder.name_exists(folder: current_directory, name: name) {
            return false
        }
        current_directory.notes.append(item)
        return true
    }
}
