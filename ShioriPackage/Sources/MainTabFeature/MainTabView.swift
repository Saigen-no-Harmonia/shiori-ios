//
//  MainTabView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/28.
//

import AboutFeature
import AccessFeature
import GreetingFeature
import PhotoGalleryFeature
import ProfileFeature
import SwiftUI

public struct MainTabView: View {
  public init () {}
  
  public var body: some View {
    TabView {
      GreetingView()
        .tabItem {
          Image(systemName: "greetingcard.fill")
          Text("ごあいさつ")
        }
      ProfileView()
        .tabItem {
          Image(systemName: "person.fill")
          Text("プロフィール")
        }
      PhotoGalleryView()
        .tabItem {
          Image(systemName: "photo")
          Text("フォトギャラリー")
        }
      AccessView()
        .tabItem {
          Image(systemName: "location.fill")
          Text("アクセス")
        }
      AboutView()
        .tabItem {
          Image(systemName: "info.circle.fill")
          Text("アプリについて")
        }
    }
    .tint(Color("primary-color", bundle: .main))
  }
}

#Preview {
  MainTabView()
}
