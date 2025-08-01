//
//  Title3Text.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/01.
//

import SwiftUI

public struct Title3Text: View {
  var text: String

  public init (_ text: String) {
    self.text = text
  }

  public var body: some View {
    Text(text)
      .font(.system(.title3, design: .serif))
      .foregroundStyle(Colors.textPrimary.color)
  }
}
