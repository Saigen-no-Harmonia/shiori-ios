//
//  Title3BoldText.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/02.
//

import SwiftUI

public struct Title3BoldText: View {
  var text: String

  public init (_ text: String) {
    self.text = text
  }

  public var body: some View {
    Text(text)
      .font(.system(.title3, design: .serif))
      .bold()
      .foregroundStyle(Colors.textPrimary.color)
  }
}
