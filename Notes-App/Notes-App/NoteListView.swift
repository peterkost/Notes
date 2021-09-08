//
//  NoteListView.swift
//  Notes-App
//
//  Created by Peter Kostin on 2021-09-08.
//

import SwiftUI

struct NoteListView: View {
    @ObservedObject var noteManager: NoteManager
    
    var body: some View {
        NavigationView {
            List {
                ForEach(noteManager.noteList, id: \.self._id) { note in
                    NavigationLink(destination: NoteEditView(noteManager: noteManager, note: note)) {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.title)
                            Text(note.note)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    noteManager.deleteNotesAt(indexSet: indexSet)
                    noteManager.fetchNotes()
                })
            }
            .navigationBarTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NoteEditView(noteManager: noteManager, note: Note(title: "", note: "", date: currentDate(), _id: ""))) {
                        Image(systemName: "square.and.pencil")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            
        }
    }
    
    // fills new note date field
    func currentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

struct NoteListView_Preview: PreviewProvider {
    static var previews: some View {
        NoteListView(noteManager: NoteManager())
    }
}
