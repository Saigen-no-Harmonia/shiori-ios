//
//  CalloutBoldText.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/05.
//

import SwiftUI

public struct CalloutBoldText: View {
  var text: String

  public init (_ text: String) {
    self.text = text
  }

  public var body: some View {
    Text(text)
      .font(.system(.callout, design: .serif))
      .bold()
      .foregroundStyle(Colors.textPrimary.color)
  }
}
