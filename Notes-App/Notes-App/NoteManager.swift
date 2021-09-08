//
//  NoteManager.swift
//  Notes-App
//
//  Created by Peter Kostin on 2021-09-08.
//

import Foundation

struct Note: Codable, Identifiable {
    var title: String
    var note: String
    var date: String
    var id: String
}

class NoteManager: ObservableObject {
    @Published private(set) var noteList: [Note]
    
    init() {
        noteList = [Note(title: "SampleNote", note: "SampleText", date: "SampleDate", id: "abc"),
                    Note(title: "SampleNote2", note: "SampleText2", date: "SampleDate2", id: "def")]
    }
}
