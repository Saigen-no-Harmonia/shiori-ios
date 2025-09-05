//
//  UIImage+Extension.swift
//  ShioriPackage
//
//  Created by canacel on 2025/09/05.
//

import UIKit

extension UIImage {
  convenience init(url: URL) {
    do {
      let data = try Data(contentsOf: url)
      self.init(data: data)!
      return
    } catch let error {
      print("Error : \(error.localizedDescription)")
    }
    self.init()
  }
}
