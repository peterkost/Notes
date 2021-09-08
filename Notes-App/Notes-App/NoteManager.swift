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
        AF.request("http://192.168.1.223:8081/fetch").response { responce in
            do {
                let data = String(data: responce.data!, encoding: .utf8)!
                self.noteList = try JSONDecoder().decode([Note].self, from: data.data(using: .utf8)!)
            } catch {
                print("Failed to decode notes.")
            }
        }

    }
}
