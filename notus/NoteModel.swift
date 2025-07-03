//
//  NoteModel.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-06-19.
//

import Foundation
import PencilKit

enum CabinetItemType {
    case Folder
    case NoteBook
    case NotePad
    
    static func get_item_type(item_type: String) -> CabinetItemType {
        switch item_type {
        case "folder":
            return .Folder
        case "notebook":
            return .NoteBook
        case "notepad":
            return .NotePad
        default:
            assert(false)
        }
    }
}

class CabinetItem : Identifiable {
    var item_type: CabinetItemType
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
    
    init(item_type: CabinetItemType) {
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

class Folder: ObservableObject {
    var name: String
    @Published var notes: [CabinetItem]
    
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
    
    func add_note(note: CabinetItem) -> Void {
        notes = notes + [note]
    }
}
