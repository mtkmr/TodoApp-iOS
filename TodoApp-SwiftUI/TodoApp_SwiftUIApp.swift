//
//  TodoApp_SwiftUIApp.swift
//  TodoApp-SwiftUI
//
//  Created by Masato Takamura on 2024/05/16.
//

import SwiftUI

@main
struct TodoApp_SwiftUIApp: App {
    init() {
        // 現状だと Alert のカスタマイズ性が低い。Alert 上のボタンカラーなどを変更するために設定が必要。
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .systemIndigo
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Category.self)
    }
}
