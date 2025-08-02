//
//  GreetingView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import Kingfisher
import SwiftUI
import Utility

public struct GreetingView: View {
  public init () {}

  public var body: some View {
    VStack(alignment: .center, spacing: 48) {
      ZStack(alignment: .bottom) {
        KFImage(URL(string: "https://placehold.jp/500x500.png"))
          .aspectRatio(contentMode: .fit)
        LinearGradient(colors: [.clear, .white], startPoint: .top, endPoint: .bottom)
          .padding(.top, 350)
        LargeTitleBoldText("ごあいさつ")
      }
      .fixedSize()
      Title3Text("本日はおひがらもよく、云々。本日はおひがらもよく、云々。本日はおひがらもよく、云々。本日はおひがらもよく、云々。本日はおひがらもよく、云々。本日はおひがらもよく、云々。")
      Spacer()
    }
    .ignoresSafeArea()
  }
}

#Preview {
  GreetingView()
}
