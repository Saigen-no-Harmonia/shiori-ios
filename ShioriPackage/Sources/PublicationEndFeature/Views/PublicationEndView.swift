//
//  PublicationEndView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/14.
//

import SwiftUI
import Utility

public struct PublicationEndView: View {
  public init() {}

  public var body: some View {
    ZStack {
      Colors.background.color.ignoresSafeArea()
      VStack(alignment: .center, spacing: 24) {
        TitleBoldText("このアプリは\n公開終了しました")
          .multilineTextAlignment(.center)
        BodyText("ご利用いただき、ありがとうございました。")
      }
      .padding(.vertical, 24)
    }
  }
}

#Preview {
  PublicationEndView()
}
