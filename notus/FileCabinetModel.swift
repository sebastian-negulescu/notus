//
//  FileCabinetModel.swift
//  notus
//
//  Created by Sebastian Negulescu on 2025-07-01.
//

import Foundation
import PencilKit
import os

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
    
    private let file_manager: FileManager = FileManager.default
    private var open_folder: URL
    
    init() {
        open_folder = file_manager.urls(for: .documentDirectory, in: .userDomainMask).first!.appending(path: "notus.data", directoryHint: .isDirectory)
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
            let contents = try file_manager.contentsOfDirectory(atPath: open_folder.absoluteString)
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
            let note = Note(name: name, contents: try PKDrawing(data: Data(contentsOf: get_note_path(name))))
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
}
