//
//  Colors.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/01.
//

import SwiftUI

public enum Colors {
  case primary
  case secondary
  case tertiary
  case textPrimary
  case background

  public var color: Color {
    switch self {
    case .primary:
      return Color(cgColor: .init(red: 201 / 255, green: 127 / 255, blue: 131 / 255, alpha: 1.0))
    case .secondary:
      return Color(cgColor: .init(red: 168 / 255, green: 201 / 255, blue: 127 / 255, alpha: 1.0))
    case .tertiary:
      return Color(cgColor: .init(red: 204 / 255, green: 201 / 255, blue: 129 / 255, alpha: 1.0))
    case .textPrimary:
      return Color(cgColor: .init(red: 33 / 255, green: 33 / 255, blue: 33 / 255, alpha: 1.0))
    case .background:
      return Color(cgColor: .init(red: 253 / 255, green: 255 / 255, blue: 240 / 255, alpha: 1.0))
    }
  }
}
