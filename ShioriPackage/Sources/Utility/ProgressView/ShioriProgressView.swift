//
//  ShioriProgressView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/07.
//

import SwiftUI

public struct ShioriProgressView: View {
  public init() {}

  public var body: some View {
    ProgressView()
      .scaleEffect(1.2)
      .tint(Colors.primary.color)
  }
}
