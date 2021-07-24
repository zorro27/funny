//
//  notesModel.swift
//  Notes
//
//  Created by Роман Зобнин on 17.03.2021.
//

import Foundation

class notesModel {
    let def = UserDefaults.standard
    static let shared = notesModel()
    
    struct cellNote: Codable {
        var title: String
        var note: String
    }
    
    var notes:[cellNote]{
        get{
            if let data = def.value(forKey: "notes") as? Data {
                return try! PropertyListDecoder().decode([cellNote].self, from: data)
            } else {
                return [cellNote]()
            }
        }
        set{
            if let data = try? PropertyListEncoder().encode(newValue) {
                def.set(data, forKey: "notes")
            }
        }
    }

    func save(title: String, note: String) {
        let note = cellNote(title: title, note: note)
        notes.append(note)
    }
    func delete (a: Int){
        notes.remove(at: a)
    }
    func overwrite(title: String, note: String, num: Int)  {
        let note = cellNote(title: title, note: note)
       
            notes.remove(at: num)
            notes.insert(note, at: num)
        
    }
}
