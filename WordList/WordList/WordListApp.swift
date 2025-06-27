//
//  WordListApp.swift
//  WordList
//
//  Created by Mac on 2025/06/27.
//

import SwiftUI
import SwiftData


@main
struct WordListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Word.self)
        }
    }
}
