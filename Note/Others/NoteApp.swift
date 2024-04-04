//
//  NoteApp.swift
//  Note
//
//  Created by นายธนภัทร สาระธรรม on 4/4/24.
//

import SwiftUI
import FirebaseCore

@main
struct NoteAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
