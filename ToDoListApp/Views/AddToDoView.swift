//
//  AddToDoView.swift
//  ToDoListApp
//
//  Created by Kevin on 2024/5/3.
//
import SwiftUI

struct AddToDoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Item title", text: $title)
                Button("Add Item") {
                    addItem()
                    
                }
            }
            .navigationTitle("Add New Item")
        }
    }
    
    private func addItem() {
        withAnimation{
            let newItem = ToDoItem(context: viewContext)
            newItem.id = UUID()
            newItem.title = self.title
            newItem.isCompleted = false
            
            do {
                try viewContext.save()
                dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
