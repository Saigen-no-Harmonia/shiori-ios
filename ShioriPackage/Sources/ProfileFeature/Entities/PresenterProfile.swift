//
//  PresenterProfile.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/01.
//

import Foundation

struct PresenterProfile: Decodable, Equatable {
  let birthDate: String
  let birthPlace: String
  let firstName: String
  let firstNameKana: String
  let hobby: String
  let job: String
  let lastName: String
  let lastNameKana: String
  let likeBy: String
  let nickName: String
  let photoURL: URL
  let ramen: String

  enum CodingKeys: String, CodingKey {
    case birthDate
    case birthPlace
    case firstName
    case firstNameKana
    case hobby
    case job
    case lastName
    case lastNameKana
    case likeBy
    case nickName
    case photoURL = "photoUrl"
    case ramen
  }
}
