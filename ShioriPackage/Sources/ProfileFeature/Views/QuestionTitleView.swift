//
//  QuestionTitleView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/05.
//

import SwiftUI
import Utility

struct QuestionTitleView: View {
  let text: String

  var body: some View {
    HStack(alignment: .center, spacing: 6) {
      Image(.ribbon)
        .resizable()
        .frame(width: 30, height: 30)
      HeadlineText(text)
        .padding(.top, 4)
    }
  }
}
