//
//  AccessGroupBoxStyle.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/14.
//

import SwiftUI
import Utility

struct AccessGroupBoxStyle: GroupBoxStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.content
      .padding()
      .background(.white)
      .overlay(RoundedRectangle(cornerRadius: 15)
        .stroke(Colors.tertiary.color, style: StrokeStyle(lineWidth: 1)))
      .clipShape(.rect(cornerRadius: 15))
  }
}
