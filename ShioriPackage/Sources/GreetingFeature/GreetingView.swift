//
//  GreetingView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/27.
//

import Kingfisher
import SwiftUI

public struct GreetingView: View {
  public init () {}

  public var body: some View {
    VStack(alignment: .center, spacing: 48) {
      ZStack(alignment: .bottom) {
        KFImage(URL(string: "https://placehold.jp/500x500.png"))
          .aspectRatio(contentMode: .fit)
        LinearGradient(colors: [.clear, .white], startPoint: .top, endPoint: .bottom)
          .padding(.top, 350)
        Text("ごあいさつ")
          .font(.system(.largeTitle, design: .serif))
          .bold()
          .padding(.bottom, 24)
          .foregroundColor(Color("text-primary-color", bundle: .main))
      }
      .fixedSize()
      Text("本日はおひがらもよく、云々。本日はおひがらもよく、云々。本日はおひがらもよく、云々。本日はおひがらもよく、云々。本日はおひがらもよく、云々。本日はおひがらもよく、云々。")
        .font(.system(.title3, design: .serif))
        .padding(.horizontal, 24)
        .foregroundColor(Color("text-primary-color", bundle: .main))
      Spacer()
    }
    .ignoresSafeArea()
  }
}

#Preview {
  GreetingView()
}
