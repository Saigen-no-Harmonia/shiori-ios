//
//  LargTitleBoldText.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/31.
//

import SwiftUI

public struct LargeTitleBoldText: View {
  var text: String

  public init (_ text: String) {
    self.text = text
  }

  public var body: some View {
    Text(text)
      .font(.system(.largeTitle, design: .serif))
      .bold()
      .foregroundStyle(Colors.textPrimary.color)
  }
}

#Preview {
  LargeTitleBoldText("test")
}
