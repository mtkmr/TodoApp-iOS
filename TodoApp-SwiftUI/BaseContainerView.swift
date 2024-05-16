//
//  BaseContainerView.swift
//  TodoApp-SwiftUI
//
//  Created by Masato Takamura on 2024/05/17.
//

import SwiftUI
import SwiftData

struct BaseContainerView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Category.createAt) private var categories: [Category] = []
    @State private var selectedCategoryId = sampleCategories.first?.id
    @State private var inputText = ""
    @State private var showAlertToAddCategory = false
    
    @FocusState private var isFocused: Bool
    
    @Namespace private var tabNamespace
    
    var body: some View {
        
        ZStack {
            VStack {
                // Tab Bar
                HStack {
                    ScrollTabBarView(
                        categories: categories,
                        selectedCategoryId: $selectedCategoryId
                    )
                    AddCategoryButton()
                }
                
                // Contents
                if categories.isEmpty {
                    CategoryIsEmptyView()
                } else {
                    TodoListContainerView(
                        categories: categories,
                        selectedCategoryId: $selectedCategoryId,
                        onDelete: { index in
                            modelContext.delete(categories[index])
                            // 残りのカテゴリーの先頭を選択しておく
                            // NOTE: アラートが消えた後に一瞬再表示されてしまうため、カテゴリーの移動を遅延するワークアラウンドを入れている
                            let startIndex = categories.startIndex
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                selectedCategoryId = categories[startIndex].id
                            }
                            
                        }
                    )
                }
            }
        }
        .alert(
            "Please enter a category name",
            isPresented: $showAlertToAddCategory
        ) {
            TextField("Category name", text: $inputText)
                .tint(.primary)
                .focused($isFocused)
                .onSubmit {
                }
                .onChange(of: inputText, { oldValue, newValue in
                })
                .onAppear(perform: {
                    // 最初からキーボードを表示したい
                    isFocused = true
                })
            
            Button(
                role: .cancel,
                action: {
                    inputText = ""
                },
                label: {
                    Text("Cancel")
                }
            )
            
            Button(
                action: {
                    if !inputText.isEmpty {
                        let newCategory = Category(title: inputText, todoList: [])
                        modelContext.insert(newCategory)
                        
                        // NOTE: コンテンツビューが指定したページに遷移してくれないため、ワークアラウンドとして遅延処理を入れている
                        DispatchQueue.main.asyncAfter(deadline : .now() + 0.1) {
                            selectedCategoryId = newCategory.id
                        }
                        inputText = ""
                    }
                },
                label: {
                    Text("Add")
                }
            )
        }
        .onAppear {
            if !categories.isEmpty {
                selectedCategoryId = categories.first?.id
            }
        }
    }
    
    @ViewBuilder
    func AddCategoryButton() -> some View {
        Button(
            action: {
                showAlertToAddCategory = true
            },
            label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(.indigo)
                    .frame(width: 44, height: 44)
            }
        )
        .shadow(
            color: .primary.opacity(0.5),
            radius: 1,
            x: 0.5,
            y: 0.5
        )
    }
    
    @ViewBuilder
    func CategoryIsEmptyView() -> some View {
        Text("Add categories by clicking the + button in the upper right corner.")
            .font(.caption)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, configurations: config)
    for category in sampleCategories {
        container.mainContext.insert(category)
    }
    return BaseContainerView()
        .modelContainer(container)
}

