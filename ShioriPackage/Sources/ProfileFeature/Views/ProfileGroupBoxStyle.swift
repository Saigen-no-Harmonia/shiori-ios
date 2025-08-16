//
//  ProfileGroupBoxStyle.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/16.
//

import SwiftUI
import Utility

struct ProfileGroupBoxStyle: GroupBoxStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.content
      .padding()
      .background(.white)
      .overlay(RoundedRectangle(cornerRadius: 15)
        .stroke(Colors.tertiary.color, style: StrokeStyle(lineWidth: 1)))
      .clipShape(.rect(cornerRadius: 15))
  }
}
