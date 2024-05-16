//
//  Todo.swift
//  TodoApp-SwiftUI
//
//  Created by Masato Takamura on 2024/05/16.
//

import Foundation

struct Todo: Identifiable, Codable {
    
    var id = UUID()
    
    var title: String
    var isChecked: Bool
    
    init(title: String, isChecked: Bool) {
        self.title = title
        self.isChecked = isChecked
    }
}

extension Todo {
    static let sample1 = Todo(title: "Sample1", isChecked: true)
    static let sample2 = Todo(title: "Sample2", isChecked: false)
    static let sample3 = Todo(title: "SampleSampleSampleSampleSampleSampleSampleSampleSampleSampleSampleSampleSampleSample", isChecked: false)
}
