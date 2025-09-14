//
//  SplashView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/14.
//

import SwiftUI
import Utility

public struct SplashView: View {
  public init() {}

  public var body: some View {
    ZStack {
      Colors.background.color.ignoresSafeArea()
      Image(.ribbon)
    }
  }
}

#Preview {
  SplashView()
}
