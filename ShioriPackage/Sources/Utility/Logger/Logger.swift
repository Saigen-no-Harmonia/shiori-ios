//
//  Logger.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/24.
//

import Foundation
import os

public enum Logger {
  public static let standard: os.Logger = .init(
    subsystem: Bundle.main.bundleIdentifier!,
    category: LogCategory.standard.rawValue
  )
}

private enum LogCategory: String {
  case standard = "Standard"
}
