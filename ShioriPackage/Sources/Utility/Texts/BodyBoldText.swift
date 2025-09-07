//
//  BodyBoldText.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/05.
//

import SwiftUI

public struct BodyBoldText: View {
  var text: String
  var color: Colors

  public init (_ text: String, color: Colors = .textPrimary) {
    self.text = text
    self.color = color
  }

  public var body: some View {
    Text(text)
      .font(.system(.body, design: .serif))
      .bold()
      .foregroundStyle(color.color)
  }
}
