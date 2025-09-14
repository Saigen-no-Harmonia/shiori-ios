//
//  AppStoreTests.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/14.
//

import ComposableArchitecture
import Foundation
import XCTest
@testable import AppFeature

@MainActor
final class AppStoreTests: XCTestCase {
  
  func test_公開終了前はisPublicationEndedがfalse() async {
    var calendar = Calendar(identifier: .gregorian)
    if let timeZone = TimeZone(identifier: "Asia/Tokyo") {
      calendar.timeZone = timeZone
    }
    calendar.locale = Locale(identifier: "ja_JP")
    let testDate = calendar.date(from: DateComponents(year: 2026, month: 1, day: 31, hour: 23, minute: 59, second: 59))!
    
    let store = TestStore(initialState: AppStore.State()) {
      AppStore()
    } withDependencies: {
      $0.date = .constant(testDate)
    }
    
    await store.send(.onFirstAppear)
  }
  
  func test_公開終了後はisPublicationEndedがtrue() async {
    var calendar = Calendar(identifier: .gregorian)
    if let timeZone = TimeZone(identifier: "Asia/Tokyo") {
      calendar.timeZone = timeZone
    }
    calendar.locale = Locale(identifier: "ja_JP")
    let testDate = calendar.date(from: DateComponents(year: 2026, month: 2, day: 1, hour: 0, minute: 0, second: 1))!
    
    let store = TestStore(initialState: AppStore.State()) {
      AppStore()
    } withDependencies: {
      $0.date = .constant(testDate)
    }
    
    await store.send(.onFirstAppear) {
      $0.isPublicationEnded = true
    }
  }
  
  func test_公開終了ちょうどではisPublicationEndedがfalse() async {
    var calendar = Calendar(identifier: .gregorian)
    if let timeZone = TimeZone(identifier: "Asia/Tokyo") {
      calendar.timeZone = timeZone
    }
    calendar.locale = Locale(identifier: "ja_JP")
    let testDate = calendar.date(from: DateComponents(year: 2026, month: 2, day: 1, hour: 0, minute: 0, second: 0))!
    
    let store = TestStore(initialState: AppStore.State()) {
      AppStore()
    } withDependencies: {
      $0.date = .constant(testDate)
    }
    
    await store.send(.onFirstAppear)
  }
}
