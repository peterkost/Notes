//
//  Notes_AppApp.swift
//  Notes-App
//
//  Created by Peter Kostin on 2021-09-08.
//

import SwiftUI

@main
struct Notes_AppApp: App {
    @StateObject var noteManager = NoteManager()
    var body: some Scene {
        WindowGroup {
            NoteListView(noteManager: noteManager)
        }
    }
}
