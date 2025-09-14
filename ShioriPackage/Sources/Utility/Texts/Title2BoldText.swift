//
//  Title2BoldText.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/14.
//

import SwiftUI

public struct Title2BoldText: View {
  var text: String

  public init (_ text: String) {
    self.text = text
  }

  public var body: some View {
    Text(text)
      .font(.system(.title2, design: .serif))
      .bold()
      .foregroundStyle(Colors.textPrimary.color)
  }
}
