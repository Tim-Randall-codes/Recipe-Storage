//
//  Recipe_StorageApp.swift
//  Recipe Storage
//
//  Created by Tim Randall on 11/11/21.
//

import SwiftUI

@main
struct Recipe_StorageApp: App {
    @StateObject var viewChanger = ViewChanger()
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            BossView(viewChanger: viewChanger).environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class ViewChanger: ObservableObject {
    @Published var num: Int = 0
}

var globalInt: Int64 = 0
