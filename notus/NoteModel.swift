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

struct CabinetItem {
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
}

struct NoteBook {
    var name: String
    var pages: [PKDrawingReference]
}

struct NotePad {
    var name: String
    var page: PKDrawingReference
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
}

class FileCabinet {
    var root: Folder = Folder(name: "")
    
    private static func get_path_folder(base: Folder, path: [String]) -> Folder? {
        var folder = base
        for part in path {
            var found_part = false
            for note in folder.notes {
                if note.name() == part {
                    if part != path.last && note.item_type != .Folder {
                        // we match with a non-folder and it's not the end of our path
                        return nil
                    }
                    
                    if note.item_type == .Folder {
                        folder = note.folder!
                        found_part = true
                    }
                    
                    break
                }
            }
            if !found_part {
                return nil
            }
        }
        
        return folder
    }
    
    func new_item(path: [String], name: String, item_type: CabinetItems) -> Bool {
        let maybe_folder = FileCabinet.get_path_folder(base: root, path: path)
        if let folder = maybe_folder {
            var item = CabinetItem(item_type: item_type)
            switch item_type {
            case .Folder:
                item.folder = Folder(name: name, notes: [])
            case .NotePad:
                item.note_pad = NotePad(name: name, page: PKDrawingReference())
            case .NoteBook:
                item.note_book = NoteBook(name: name, pages: [PKDrawingReference()])
            }
            folder.notes.append(item)
            return true
        }
        
        return false
    }
}
