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
                ForEach(noteManager.noteList, id: \.self.title) { note in
                    NavigationLink(destination: NoteEditView(noteManager: noteManager, note: note)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(note.title)
                                    .font(.title)
                                Spacer()
                                Text(note.date)
                            }
                            Text(note.note)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    noteManager.deleteNotesAt(indexSet: indexSet)
                })
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(trailing: NavigationLink(destination: NoteEditView(noteManager: noteManager, note: Note(title: "", note: "", date: "", _id: ""))) {
                Text("New Note")
            })
        }
    }
}

struct NoteListView_Preview: PreviewProvider {
    static var previews: some View {
        NoteListView(noteManager: NoteManager())
    }
}
