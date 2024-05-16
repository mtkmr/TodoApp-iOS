//
//  Category.swift
//  TodoApp-SwiftUI
//
//  Created by Masato Takamura on 2024/05/17.
//

import Foundation
import SwiftData

@Model
final class Category: Identifiable, ObservableObject {
    
    let id = UUID()
    let createAt = Date()
    let title: String
    var todoList: [Todo]
    
    init(title: String, todoList: [Todo]) {
        self.title = title
        self.todoList = todoList
    }
}

var sampleCategories: [Category] = [
    Category(
        title: "カテゴリー１",
        todoList: [
            Todo(title: "じゃがいも", isChecked: true),
            Todo(title: "りんご", isChecked: false),
            Todo(title: "ハチミツ", isChecked: false),
            Todo(title: "きゅうり", isChecked: false),
            Todo(title: "マヨネーズ", isChecked: false),
            Todo(title: "ケチャップ", isChecked: false),
            Todo(title: "油", isChecked: false),
        ]
    ),
    Category(
        title: "2",
        todoList: [
            Todo(title: "カレー粉", isChecked: true),
            Todo(title: "みかん", isChecked: false),
            Todo(title: "グレープフルーツ", isChecked: false),
            Todo(title: "チョコ", isChecked: false),
            Todo(title: "アイス", isChecked: false),
            Todo(title: "ブドウ", isChecked: false),
            Todo(title: "オレンジ", isChecked: true),
            Todo(title: "みかん", isChecked: false),
            Todo(title: "グミ", isChecked: false),
            Todo(title: "ポテチ", isChecked: false),
            Todo(title: "カップ麺", isChecked: false),
            Todo(title: "コーラ", isChecked: false),
        ]
    ),
    Category(
        title: "カテ3",
        todoList: [
            Todo(title: "パスタ", isChecked: true),
            Todo(title: "トマト", isChecked: false),
            Todo(title: "トマト缶", isChecked: true),
            Todo(title: "バジル", isChecked: false),
            Todo(title: "にんにくチューブ", isChecked: true),
            Todo(title: "生姜チューブ", isChecked: false),
            Todo(title: "生わさび", isChecked: true),
            Todo(title: "醤油", isChecked: false),
        ]
    ),
    Category(
        title: "カテゴリー4",
        todoList: [
            Todo(title: "ブロッコリー", isChecked: true),
            Todo(title: "いちご", isChecked: false),
            Todo(title: "餃子の皮", isChecked: false),
            Todo(title: "ひき肉", isChecked: false),
            Todo(title: "ヨーグルト", isChecked: false),
            Todo(title: "酢", isChecked: false),
            Todo(title: "冷凍ブロッコリー", isChecked: false),
        ]
    ),
    Category(
        title: "カテゴリー5",
        todoList: []
    ),
]
