//
//  CategoryCell.swift
//  Quiz
//
//  Created by Jakob Handke on 08.05.26.
//

import SwiftUI

struct CategoryCell: View {
    let category: Category
    let selected: Bool
    let large: Bool
    var square: Bool = true

    var body: some View {
        Text(category.name)
            .font(large ? .externalBody : .default)
            .fontWeight(.semibold)
            .strikethrough(category.state == .answered)

            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(square ? 1 : nil, contentMode: .fit)
            .background {
                if case category.state = .answered {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(Color.gray.gradient)
                        .opacity(0.7)
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(selected ? Color.orange.gradient : Color.blue.gradient)
                }
            }
    }
}

#Preview {
    CategoryCell(category: Category(name: QuestionSet.example.questions.first!.category, state: .answered), selected: false, large: false)
}
