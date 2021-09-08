//
//  NoteManager.swift
//  Notes-App
//
//  Created by Peter Kostin on 2021-09-08.
//

import Foundation
import Alamofire

struct Note: Codable {
    var title: String
    var note: String
    var date: String
    var _id: String

}

class NoteManager: ObservableObject {
    @Published private(set) var noteList = [Note]()
    
    init() {
        fetchNotes()
    }
    
    // MARK: - CRUD
    
    func fetchNotes() {
        AF.request("http://192.168.1.223:8081/fetch").response { responce in
            do {
                let data = String(data: responce.data!, encoding: .utf8)!
                self.noteList = try JSONDecoder().decode([Note].self, from: data.data(using: .utf8)!)
            } catch {
                print("Failed to decode notes.")
            }
        }
    }
    
    func addNote(_ note: Note) {
        AF.request("http://192.168.1.223:8081/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": note.title, "date": note.date, "note": note.note]).responseJSON { responce in
            print("Add res: \(responce)")
        }
    }
    
    func updateNote(_ note: Note) {
        AF.request("http://192.168.1.223:8081/update", method: .post, encoding: URLEncoding.httpBody, headers: ["title": note.title, "date": note.date, "note": note.note, "id":note._id]).responseJSON { responce in
            print("Update res: \(responce)")
        }
    }
    
    func deleteNotesAt(indexSet: IndexSet) {
        for i in indexSet {
            let targetNoteID = noteList[i]._id
            
            AF.request("http://192.168.1.223:8081/delete", method: .post, encoding: URLEncoding.httpBody, headers: ["id":targetNoteID]).responseJSON { responce in
                print("Delete res: \(responce)")
            }
        }
    }
}
