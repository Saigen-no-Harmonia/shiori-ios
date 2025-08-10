//
//  DateFormatter+Extension.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/03.
//

import Foundation

extension DateFormatter {
  // yyyy年M月d日 HH:mm
  public static let yearMonthDayHourMinute: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ja_JP")
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
    dateFormatter.calendar = .init(identifier: .gregorian)
    dateFormatter.dateFormat = "yyyy年M月d日 HH:mm"
    return dateFormatter
  }()
}
