//
//  FileCabinetModel.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-07-01.
//

import Foundation
import PencilKit
import os

enum CabinetItems {
    case note
    case folder
}

struct Note {
    var name: String
    var contents: PKDrawing
}

struct Folder {
    var name: String
    var contents: [String]
}


class FileCabinet {
    var desk: Note? = nil
    var open_folder: URL
    
    private let file_manager: FileManager = FileManager.default
    private let root_path: URL
    
    init() {
        root_path = file_manager.urls(for: .documentDirectory, in: .userDomainMask).first!.appending(path: "notus.data", directoryHint: .isDirectory)
        open_folder = root_path
        if !file_manager.fileExists(atPath: open_folder.path()) {
            os_log("root folder does not exist", type: .info)
            do {
                try file_manager.createDirectory(at: open_folder, withIntermediateDirectories: true)
                os_log("root folder created at: %s", type: .info, open_folder.path())
            } catch {
                os_log("Could not create root folder: %s", type: .error, error.localizedDescription)
            }
        }
    }
    
    private func get_note_path(_ name: String) -> URL {
        return open_folder.appending(path: name, directoryHint: .notDirectory)
    }
    
    // TODO: run CRUD operations in a DispatchQueue
    // TOOD: make CRUD functions generic
    
    func create_folder(name: String) -> Bool {
        let path = open_folder.appending(path: name, directoryHint: .isDirectory)
        do {
            try file_manager.createDirectory(at: path, withIntermediateDirectories: false)
            self.open_folder = path
            return true
        } catch {
            os_log("Could not create folder: %s", type: .error, error.localizedDescription)
        }
        return false
    }
    
    func read_folder() -> [String]? {
        do {
            let contents = try file_manager.contentsOfDirectory(atPath: open_folder.path())
            return contents
        } catch {
            os_log("Could not read folder: %s", type: .error, error.localizedDescription)
        }
        
        return nil
    }
    
    func delete_folder(name: String) -> Bool {
        do {
            try file_manager.removeItem(at: open_folder.appending(path: name, directoryHint: .isDirectory))
        } catch {
            os_log("Could not delete folder: %s", type: .error, error.localizedDescription)
        }
        return false
    }
    
    func ascend_folder() -> [String]? {
        let open_folder_backup = self.open_folder
        self.open_folder = open_folder.deletingLastPathComponent()
        if let contents: [String] = read_folder() {
            return contents
        }
        self.open_folder = open_folder_backup
        return read_folder()
    }
    
    func descend_folder(name: String) -> [String]? {
        let open_folder_backup = self.open_folder
        self.open_folder = open_folder.appending(path: name, directoryHint: .isDirectory)
        if let contents: [String] = read_folder() {
            return contents
        }
        self.open_folder = open_folder_backup
        return read_folder()
    }
    
    func create_note(name: String) -> Bool {
        let new_note = PKDrawing()
        
        do {
            try new_note.dataRepresentation().write(to: get_note_path(name))
            return true
        } catch {
            os_log("Could not create note: %s", type: .error, error.localizedDescription)
        }
        
        return false
    }
    
    func read_note(name: String) -> Note? {
        do {
            let note_contents = try PKDrawing(data: Data(contentsOf: get_note_path(name)))
            let note = Note(name: name, contents: note_contents)
            return note
        } catch {
            os_log("Could not load note: %s", type: .error, error.localizedDescription)
        }
        
        return nil
    }
    
    func update_note(note: Note) -> Bool {
        do {
            try note.contents.dataRepresentation().write(to: get_note_path(note.name))
            return true
        } catch {
            os_log("Could not update note: %s", type: .error, error.localizedDescription)
        }
        
        return false
    }
    
    func delete_note(name: String) -> Bool {
        do {
            try file_manager.removeItem(at: get_note_path(name))
            return true
        } catch {
            os_log("Could not delete note: %s", type: .error, error.localizedDescription)
        }
        
        return false
    }
    
    func item_type(name: String, _ relative: Bool = false) -> CabinetItems {
        var file_path: URL = open_folder.appending(path: name)
        if !relative {
            file_path = root_path.appending(path: name)
        }
        
        var is_dir: ObjCBool = false
        assert(file_manager.fileExists(atPath: file_path.path(), isDirectory: &is_dir))
        
        if is_dir.boolValue {
            return CabinetItems.folder
        }
        
        return CabinetItems.note
    }
}
