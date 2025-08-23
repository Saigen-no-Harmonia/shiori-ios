//
//  MainTabView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/07/28.
//

import AboutFeature
import AccessFeature
import ComposableArchitecture
import GreetingFeature
import PhotoGalleryFeature
import ProfileFeature
import SwiftUI
import Utility

public struct MainTabView: View {
  public init () {
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: "HiraMinProN-W6", size: 10)! ], for: .normal)
    UITabBar.appearance().backgroundColor = UIColor(Colors.background.color)
  }
  
  public var body: some View {
    TabView {
      GreetingView(store: StoreOf<GreetingStore>(
        initialState: GreetingStore.State()) {
          GreetingStore()
        }
      )
      .tabItem {
        Image(systemName: "greetingcard.fill")
        Text("ごあいさつ")
      }
      ProfileView(store: StoreOf<ProfileStore>(
        initialState: ProfileStore.State()) {
          ProfileStore()
        }
      )
      .tabItem {
        Image(systemName: "person.fill")
        Text("プロフィール")
      }
      PhotoGalleryView(store: StoreOf<PhotoGalleryStore>(
        initialState: PhotoGalleryStore.State()) {
          PhotoGalleryStore()
        }
      )
      .tabItem {
        Image(systemName: "photo")
        Text("フォトギャラリー")
      }
      AccessView(store: StoreOf<AccessStore>(
        initialState: AccessStore.State()) {
          AccessStore()
        }
      )
        .tabItem {
          Image(systemName: "location.fill")
          Text("アクセス")
        }
      AboutView(store: StoreOf<AboutStore>(
        initialState: AboutStore.State()) {
          AboutStore()
        }
      )
      .tabItem {
        Image(systemName: "info.circle.fill")
        Text("アプリについて")
      }
    }
    .tint(Colors.primary.color)
  }
}

#Preview {
  MainTabView()
}
