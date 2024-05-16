//
//  ContentView.swift
//  TodoApp-SwiftUI
//
//  Created by Masato Takamura on 2024/05/17.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        BaseContainerView()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, configurations: config)
    return BaseContainerView()
        .modelContainer(container)
}
