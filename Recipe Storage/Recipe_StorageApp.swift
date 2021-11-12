//
//  Recipe_StorageApp.swift
//  Recipe Storage
//
//  Created by Tim Randall on 11/11/21.
//

import SwiftUI

@main
struct Recipe_StorageApp: App {
    @StateObject var name = Name()
    @StateObject var page = PageSelector()
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView(name: name, page: page).environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class Name: ObservableObject {
    @Published var word: String = ""
}

class PageSelector: ObservableObject {
    @Published var num: Int = 0
}
