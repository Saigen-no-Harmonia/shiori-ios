//
//  AboutView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import SwiftUI

public struct AboutView: View {
  public init () {}

  public var body: some View {
    NavigationStack {
      List {
        Text("ライセンス情報")
        HStack {
          Text("バージョン")
          Spacer()
          Text("v1.0.0")
        }
        HStack {
          Text("ソースコード")
          Spacer()
          Text("")
        }
      }
      .navigationTitle("アプリについて")
      .toolbarBackground(.white, for: .navigationBar)
    }
  }
}

#Preview {
  AboutView()
}
