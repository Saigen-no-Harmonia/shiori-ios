//
//  ProfileView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import Kingfisher
import Parchment
import SwiftUI
import Utility

public struct ProfileView: View {
  public init () {}

  public var body: some View {
    PageView {
      Page("ほげ家") {
        Text("Page 0")
      }
      Page("ふが家") {
        Text("Page 1")
      }
    }
  }
}

#Preview {
  ProfileView()
}
