//
//  BodyText.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/02.
//

import SwiftUI

public struct BodyText: View {
  var text: String
  var color: Colors

  public init (_ text: String, color: Colors = .textPrimary) {
    self.text = text
    self.color = color
  }

  public var body: some View {
    Text(text)
      .font(.system(.body, design: .serif))
      .foregroundStyle(color.color)
  }
}
