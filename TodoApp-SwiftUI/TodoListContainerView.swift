//
//  TodoListContainerView.swift
//  TodoApp-SwiftUI
//
//  Created by Masato Takamura on 2024/05/17.
//

import SwiftUI
import SwiftData

struct TodoListContainerView: View {
    
    @State private var showConfirmDeleteCategoryAlert = false
    
    var categories: [Category]
    @Binding var selectedCategoryId: UUID?
    
    var onDelete: (Int) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach(categories) { category in
                    VStack {
                        HStack {
                            Spacer()
                            Button(
                                action: {
                                    showConfirmDeleteCategoryAlert = true
                                },
                                label: {
                                    Text("Delete this list")
                                        .multilineTextAlignment(.trailing)
                                }
                            )
                            .padding()
                            .tint(.purple)
                            .alert(
                                "Delete this todo list?",
                                isPresented: $showConfirmDeleteCategoryAlert,
                                actions: {
                                    Button(
                                        "Cancel",
                                        role: .cancel,
                                        action: {}
                                    )
                                    
                                    Button(
                                        "Delete",
                                        role: .destructive,
                                        action: {
                                            guard let index = categories.firstIndex(where: { $0.id == selectedCategoryId }) else { return }
                                            onDelete(index)
                                        }
                                    )
                                },
                                message: {
                                    Text("This operation cannot be undone.")
                                }
                            )
                        }
                        
                        TodoListView(category: category)
                            .containerRelativeFrame(.horizontal)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $selectedCategoryId)
        .animation(.easeInOut, value: selectedCategoryId)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, configurations: config)
    return TodoListContainerView(categories: sampleCategories, selectedCategoryId: .constant(sampleCategories[0].id), onDelete: {_ in})
        .modelContainer(container)
}
