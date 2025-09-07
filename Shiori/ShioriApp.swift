//
//  ShioriApp.swift
//  Shiori
//
//  Created by canacel on 2025/07/21.
//

import AppFeature
import SwiftUI
import Kingfisher

@main
struct ShioriApp: App {
  init() {
    // Kingfisherのグローバル設定
    ImageCache.default.memoryStorage.config.totalCostLimit = 50 * 1024 * 1024 // 50MB
    ImageCache.default.memoryStorage.config.countLimit = 100 // 100枚
    ImageCache.default.memoryStorage.config.expiration = .seconds(300) // 5分
    ImageCache.default.diskStorage.config.sizeLimit = 200 * 1024 * 1024 // 200MB
  }

  var body: some Scene {
    WindowGroup {
      AppView()
        .preferredColorScheme(.light)
    }
  }
}
