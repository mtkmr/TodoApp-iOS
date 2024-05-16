//
//  ScrollTabBarView.swift
//  TodoApp-SwiftUI
//
//  Created by Masato Takamura on 2024/05/17.
//

import SwiftUI
import SwiftData

struct ScrollTabBarView: View {
    
    @Namespace private var tabNamespace
    
    var categories: [Category]
    @Binding var selectedCategoryId: UUID?
    
    var body: some View {
        VStack {
            ScrollViewReader(content: { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories) { category in
                            Button(action: {
                                selectedCategoryId = category.id
                            }) {
                                Text(category.title)
                                    .foregroundStyle(.primary)
                                    .fontWeight(category.id == selectedCategoryId ? .bold : .regular)
                                    .padding(8)
                            }
                            .id(category.id)
                            .buttonStyle(NotHighlightButtonStyle())
                            .background(category.id == selectedCategoryId ? .purple : .clear)
                            .clipShape(.rect(cornerRadius: 24))
                            .matchedGeometryEffect(
                                id: category.id, in: tabNamespace, isSource: true
                            )
                        }
                        .padding(.leading, 8)
                    }
                }
                .onChange(of: selectedCategoryId) { oldValue, newValue in
                    withAnimation(.snappy) {
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            })
        }
    }
}

/// ボタンタップ時のハイライトを無効化する ButtonStyle
/// ref: https://qiita.com/hatoribe/items/434365ac31507b2793a7
struct NotHighlightButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Category.self, configurations: config)
    return Group {
        ScrollTabBarView(categories: sampleCategories, selectedCategoryId: .constant(sampleCategories[2].id))
        ScrollTabBarView(categories: sampleCategories, selectedCategoryId: .constant(sampleCategories[1].id))
    }
    .modelContainer(container)
}
