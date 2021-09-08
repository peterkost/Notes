//
//  NoteEditView.swift
//  Notes-App
//
//  Created by Peter Kostin on 2021-09-08.
//

import SwiftUI

struct NoteEditView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var noteManager: NoteManager
    @State var note: Note
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $note.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Section(header: Text("Note")) {
                TextField("Note", text: $note.note)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Section(header: Text("Date")) {
                TextField("Date", text: $note.date)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .navigationBarTitle("Edit Note")
        .navigationBarItems(
            trailing:
                Button(action: {
                    note._id == "" ? noteManager.addNote(note) : noteManager.updateNote(note)
                    noteManager.fetchNotes()
                    presentation.wrappedValue.dismiss()
                    
                }) {
                    Text("Update")
                })
    }
}

//struct NoteEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteEditView(note: Note(title: "SampleNote", note: "SampleText", date: "SampleDate", id: "abc"))
//    }
//}
