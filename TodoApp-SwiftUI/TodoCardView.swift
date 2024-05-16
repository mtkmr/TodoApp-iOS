//
//  TodoCardView.swift
//  TodoApp-SwiftUI
//
//  Created by Masato Takamura on 2024/05/17.
//

import SwiftUI

struct TodoCardView: View {
    
    // 連打を防ぐために、x ボタンをタップして disabled を切り替えるためのフラグ
    @State private var isDisabled = false
    
    @Binding var todo: Todo
    
    var onDelete: (Todo) -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            
            Image(systemName: todo.isChecked ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(.purple)
                .font(.system(size: 28))
            
            Text(todo.title)
                .font(.system(size: 20))
                .foregroundStyle(todo.isChecked ? .gray : .primary)
                .strikethrough(todo.isChecked && !todo.title.isEmpty, color: todo.isChecked ? .gray : .primary)
            
            Spacer(minLength: 0)
            
            Button(action: {
                isDisabled = true
                onDelete(todo)
            }, label: {
                Image(systemName: "xmark")
            })
            .foregroundStyle(.purple)
            .font(.system(size: 16))
            .disabled(isDisabled)
        }
        .padding()
        .onTapGesture {
            todo.isChecked.toggle()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        TodoCardView(todo: .constant(Todo.sample1), onDelete: {_ in })
        TodoCardView(todo: .constant(Todo.sample2), onDelete: {_ in })
        TodoCardView(todo: .constant(Todo.sample3), onDelete: {_ in })
    }
}

