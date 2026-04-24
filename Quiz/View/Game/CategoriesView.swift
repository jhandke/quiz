//
//  CategoriesView.swift
//  Quiz
//
//  Created by Jakob Handke on 21.03.26.
//

import SwiftUI

struct CategoriesView: View {
    var questions = QuestionSet.example.questions

    var body: some View {
        Grid {
            ForEach(questions.indices, id: \.self) { index in
                
            }
        }
    }
}

#Preview {
    CategoriesView()
}
