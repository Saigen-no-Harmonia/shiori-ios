//
//  HeadlineText.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/02.
//

import SwiftUI

public struct HeadlineText: View {
  var text: String

  public init (_ text: String) {
    self.text = text
  }

  public var body: some View {
    Text(text)
      .font(.system(.headline, design: .serif))
      .foregroundStyle(Colors.textPrimary.color)
  }
}
