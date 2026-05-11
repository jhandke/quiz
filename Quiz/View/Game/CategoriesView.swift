//
//  CategoriesView.swift
//  Quiz
//
//  Created by Jakob Handke on 21.03.26.
//

import SwiftUI

struct CategoriesView: View {
    let categories: [Category]
    @Binding var selectedCategoryIndex: Int
    var large: Bool = false

    var body: some View {
        Grid {
            let amount = categories.count
            let rowLength = large ? 3 : 4
            let colLength = large ? 4 : 3
            let rows = (amount / rowLength) + 1
//            let cols = (amount / colLength) + 1
            return ForEach(0..<rows, id: \.self) { row in
                GridRow {
                    let columnEnd: Int = if amount - row * colLength > colLength { colLength } else { amount - row * colLength }
                    ForEach(0..<columnEnd, id: \.self) { column in
                        let (category, index) = categoryFor(row, column)
                        CategoryCell(category: category, selected: selectedCategoryIndex == index, large: large)
                            .onTapGesture {
                                if case category.state = .answered { return }
                                withAnimation {
                                    selectedCategoryIndex = index
                                }
                            }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func categoryFor(_ row: Int, _ column: Int) -> (Category, Int) {
        let amountOfRows = large ? categories.count / 3 : categories.count / 4
        let index = row * amountOfRows + column
        return (categories[index], index)
    }
}

#Preview {
    @Previewable @State var selection = -1
    let large = false
    let categories = QuestionSet.reduced.questions.map { question in
        return Category(name: question.category, state: Double.random(in: 0...1) < 0.3 ? .answered : .unanswered)
    }

    CategoriesView(
        categories: categories,
        selectedCategoryIndex: $selection,
        large: large
    )
}
