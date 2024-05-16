//
//  TodoListView.swift
//  TodoApp-SwiftUI
//
//  Created by Masato Takamura on 2024/05/17.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    
    @FocusState private var isFocused: Bool
    
    @State private var inputText = ""
    
    @Bindable var category: Category
    
    var body: some View {
        VStack {
            if category.todoList.isEmpty {
                Text("Please add a todo from the input field below.")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.callout)
            } else {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack {
                            ForEach($category.todoList) { todo in
                                TodoCardView(todo: todo, onDelete: { todo in
                                    withAnimation {
                                        if let index = category.todoList.firstIndex(where: { $0.id == todo.id }) {
                                            category.todoList.remove(at: index)
                                        }
                                    }
                                })
                                .id(todo.id)
                            }
                        }
                    }
                    .onChange(of: category.todoList.last?.id) { oldValue, newValue in
                        // todo が追加されたら、その位置までスクロールする
                        withAnimation {
                            proxy.scrollTo(newValue)
                        }
                    }
                }
            }
            
            HStack {
                TextField("Please your enter todo.", text: $inputText)
                    .tint(.primary)
                    .textFieldStyle(.plain)
                    .lineLimit(5)
                    .focused($isFocused)
                    .onSubmit {
                        if !inputText.isEmpty {
                            let todo = Todo(title: inputText, isChecked: false)
                            inputText = ""
                            withAnimation {
                                category.todoList.append(todo)
                            }
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                    .background(.white)
                    .cornerRadius(10)
                
                if isFocused {
                    Button(
                        action: {
                            isFocused = false
                        },
                        label: {
                            Image(systemName: "keyboard.chevron.compact.down.fill")
                                .font(.system(size: 24))
                        }
                    )
                    .tint(.primary)
                }
            }
            .padding(.horizontal, 12)
            .frame(minHeight: 80)
            .background(.ultraThinMaterial)
        }
    }
}

#Preview() {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, configurations: config)
    return TodoListView(
        category: sampleCategories[1]
    )
    .modelContainer(container)
}

