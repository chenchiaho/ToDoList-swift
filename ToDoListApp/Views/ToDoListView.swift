//
//  ContentView.swift
//  ToDoListApp
//
//  Created by Kevin on 2024/5/2.
//

import SwiftUI
import CoreData

struct ToDoListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: ToDoItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDoItem.title, ascending: true)],
        animation: .default)
    var toDoItems: FetchedResults<ToDoItem>

    var body: some View {
        NavigationView {
            List {
                if toDoItems.isEmpty {
                    Text("No items yet")
                } else {
                    ForEach(toDoItems, id: \.id) { item in
                        ToDoItemView(item: item)
                    }
                    .onDelete(perform: deleteItems)
                }
                
            }
            .navigationTitle("To-Do List")
            .navigationBarItems(trailing: NavigationLink("Add", destination: AddToDoView()))
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = toDoItems[index]
            viewContext.delete(item)
        }
        do {
            try viewContext.save()
        } catch {
            
            print(error.localizedDescription)
        }
    }
}


struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared
        return ToDoListView().environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
