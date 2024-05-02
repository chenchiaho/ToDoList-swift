//
//  ToDoListAppApp.swift
//  ToDoListApp
//
//  Created by Kevin on 2024/5/2.
//

import SwiftUI

@main
struct ToDoListAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
