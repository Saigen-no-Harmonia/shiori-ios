//
//  CaptionText.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/14.
//

import SwiftUI

public struct CaptionText: View {
  var text: String
  var color: Colors

  public init (_ text: String, color: Colors = .textPrimary) {
    self.text = text
    self.color = color
  }

  public var body: some View {
    Text(text)
      .font(.system(.caption, design: .serif))
      .foregroundStyle(color.color)
  }
}
