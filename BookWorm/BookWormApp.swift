//
//  BookWormApp.swift
//  BookWorm
//
//  Created by surya sai on 01/05/24.
//

import SwiftUI
import SwiftData

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:Book.self)
    }
}
