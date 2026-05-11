//
//  CountDownView.swift
//  Quiz
//
//  Created by Jakob Handke on 10.05.26.
//

import SwiftUI

struct CountDownView: View {
    var remainingSeconds: Int
    var large: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text("Restliche Zeit")
                .font(large ? .externalBody : .title2)
            Text("\(remainingSeconds) s")
                .contentTransition(.numericText(countsDown: true))
                .font(large ? .externalTitle : .title)
                .fontWeight(.semibold)
        }
        .padding()
        .frame(alignment: .top)
        .background(Color.mint.gradient, in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    @Previewable @State var seconds = 12
    CountDownView(remainingSeconds: seconds, large: true)
}
