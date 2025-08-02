//
//  OnFirstAppear.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/02.
//

import SwiftUI

struct OnFirstAppear: ViewModifier {
  let perform: () -> Void
  
  @State private var firstTime = true
  
  func body(content: Content) -> some View {
    content.onAppear {
      if firstTime {
        firstTime = false
        perform()
      }
    }
  }
}

extension View {
  public func onFirstAppear(_ perform: @escaping () -> Void) -> some View {
    modifier(OnFirstAppear(perform: perform))
  }
}
