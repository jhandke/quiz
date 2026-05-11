//
//  View+multilineSubmit.swift
//  Quiz
//
//  Created by Jakob Handke on 10.05.26.
//

// Stolen from https://danielsaidi.com/blog/2023/09/15/dismissing-a-multiline-textfield-with-the-return-key-in-swiftui

import SwiftUI

struct MultilineSubmitViewModifier: ViewModifier {
    @Binding private var text: String
    private let submitLabel: SubmitLabel
    private let onSubmit: () -> Void

    @FocusState private var isFocused: Bool

    init(text: Binding<String>, submitLabel: SubmitLabel, onSubmit: @escaping () -> Void) {
        self._text = text
        self.submitLabel = submitLabel
        self.onSubmit = onSubmit
    }

    func body(content: Content) -> some View {
        content
            .focused($isFocused)
            .submitLabel(submitLabel)
            .onChange(of: text) { _, newValue in
                guard isFocused else { return }
                guard newValue.contains("\n") else { return }
                isFocused = false
                text = newValue.replacingOccurrences(of: "\n", with: "")
                onSubmit()
            }
    }
}

public extension View {
    func multilineSubmit(
        for text: Binding<String>,
        submitLabel: SubmitLabel = .done
    ) -> some View {
        self.modifier(
            MultilineSubmitViewModifier(
                text: text,
                submitLabel: submitLabel,
                onSubmit: {}
            )
        )
    }
}

public extension View {
    func onMultilineSubmit(
        in text: Binding<String>,
        submitLabel: SubmitLabel = .done,
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(
            MultilineSubmitViewModifier(
                text: text,
                submitLabel: submitLabel,
                onSubmit: action
            )
        )
    }
}
