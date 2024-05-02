//
//  ToDoItemView.swift
//  ToDoListApp
//
//  Created by Kevin on 2024/5/3.
//

import SwiftUI

struct ToDoItemView: View {
    
    @ObservedObject var item: ToDoItem
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var body: some View {
            HStack {
                Text(item.title ?? "Untitled")
                    .strikethrough(item.isCompleted, color: .gray) // Strikethrough if completed.
                    .foregroundColor(item.isCompleted ? .gray : .black) // Change text color if completed.
                Spacer()
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .onTapGesture {
                        toggleCompletion()
                    }
                    .foregroundColor(item.isCompleted ? .green : .gray)
            }
            .padding(.vertical, 8)
        }
    
    private func toggleCompletion() {
        withAnimation{
            item.isCompleted.toggle()
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



struct ToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newItem = ToDoItem(context: viewContext)
        newItem.id = UUID()
        newItem.title = "Sample Task"
        newItem.isCompleted = false
        return ToDoItemView(item: newItem)
    }
}
