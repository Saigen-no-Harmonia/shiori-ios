//
//  ToastView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/14.
//

import SwiftUI

public struct ToastView: View {
  let message: String
  let image: String

  public init(message: String, image: String) {
    self.message = message
    self.image = image
  }

  public var body: some View {
    VStack(spacing: 16) {
      Image(systemName: image)
        .resizable()
        .frame(width: 50, height: 50)
        .foregroundStyle(Colors.textPrimary80.color)
      BodyBoldText(message, color: .textPrimary80)
    }
    .padding(.all, 16)
    .background(.white.opacity(0.8))
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .overlay(alignment: .center) {
      RoundedRectangle(cornerRadius: 12)
        .stroke(Colors.textPrimary80.color, lineWidth: 1)
    }
  }
}

#Preview {
  ToastView(message: "成功しました", image: "checkmark.circle.fill")
}
