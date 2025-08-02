//
//  ProfileRepository.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/02.
//

import ComposableArchitecture
import Foundation

@DependencyClient
struct ProfileRepository: Sendable {
  var getProfile: @Sendable () async throws -> Families
}

extension ProfileRepository: DependencyKey {
  static let liveValue = Self(getProfile: { await mock })
  static let testValue = Self(getProfile: { await mock })
}

extension ProfileRepository {
  @MainActor static let mock = Families(
    families: [
      Family(id: "1",
             name: "ほげ",
             presenter: PresenterProfile(birthDate: "2020-01-01",
                                         birthPlace: "地球",
                                         firstName: "山田",
                                         firstNameKana: "やまだ",
                                         hobby: "釣り",
                                         job: "自宅警備員",
                                         lastName: "太郎",
                                         lastNameKana: "たろう",
                                         likeBy: "すべて",
                                         nickName: "太郎くん",
                                         photoURL: URL(string: "https://placehold.jp/500x500.png")!,
                                         ramen: "醤油ラーメン"),
             participants: [
               ParticipantProfile(id: "1",
                                  birthDate: "1950-01-01",
                                  birthPlace: "火星",
                                  firstName: "山田",
                                  firstNameKana: "やまだ",
                                  hobby: "体温を測ること",
                                  job: "ファッションデザイナー",
                                  lastName: "誠",
                                  lastNameKana: "まこと",
                                  likeFood: "焼肉",
                                  message: "この度はまことにおめでとうございます。まことだけに。",
                                  photoURL: URL(string: "https://placehold.jp/500x500.png")!,
                                  relation: "父"),
               ParticipantProfile(id: "2",
                                  birthDate: "1950-12-31",
                                  birthPlace: "金木犀",
                                  firstName: "山田",
                                  firstNameKana: "やまだ",
                                  hobby: "ぬいぐるみ作り",
                                  job: "ITエンジニア",
                                  lastName: "誠子",
                                  lastNameKana: "せいこ",
                                  likeFood: "刺身・特に馬刺し",
                                  message: "最近、馬刺しブームが来てます。みんなで馬刺し食べに行きましょう！",
                                  photoURL: URL(string: "https://placehold.jp/500x500.png")!,
                                  relation: "母")
             ],
             nekos: nil),
      Family(id: "2",
             name: "ふが",
             presenter: PresenterProfile(birthDate: "2020-01-01",
                                         birthPlace: "太陽系",
                                         firstName: "田中",
                                         firstNameKana: "たなか",
                                         hobby: "特になし",
                                         job: "猫の世話・花火を見る",
                                         lastName: "花子",
                                         lastNameKana: "はなこ",
                                         likeBy: "すべてすべてすべて",
                                         nickName: "花子さん",
                                         photoURL: URL(string: "https://placehold.jp/500x500.png")!,
                                         ramen: "しおラーメン"),
             participants: [
               ParticipantProfile(id: "1",
                                  birthDate: "1950-01-01",
                                  birthPlace: "彗星に乗ってきました",
                                  firstName: "田中",
                                  firstNameKana: "たなか",
                                  hobby: "ドラマ鑑賞",
                                  job: "パンダの飼育員",
                                  lastName: "二郎",
                                  lastNameKana: "じろう",
                                  likeFood: "笹団子",
                                  message: "おめでとうございます。",
                                  photoURL: URL(string: "https://placehold.jp/500x500.png")!,
                                  relation: "父"),
               ParticipantProfile(id: "2",
                                  birthDate: "1950-12-31",
                                  birthPlace: "金木犀",
                                  firstName: "田中",
                                  firstNameKana: "たなか",
                                  hobby: "お菓子作り",
                                  job: "警備員",
                                  lastName: "しおり",
                                  lastNameKana: "しおり",
                                  likeFood: "ケーキ",
                                  message: "まさか娘が結婚するとは、思ってもみなかったです。おめでとう！",
                                  photoURL: URL(string: "https://placehold.jp/500x500.png")!,
                                  relation: "母"),
               ParticipantProfile(id: "3",
                                  birthDate: "2000-01-01",
                                  birthPlace: "川の下で拾われたらしい",
                                  firstName: "田中",
                                  firstNameKana: "たなか",
                                  hobby: "YouTubeを見る",
                                  job: "学生",
                                  lastName: "ロキ",
                                  lastNameKana: "ろき",
                                  likeFood: "マック",
                                  message: "😄",
                                  photoURL: URL(string: "https://placehold.jp/500x500.png")!,
                                  relation: "妹"),
             ],
             nekos: [
               NekoProfile(id: "1",
                           age: 10,
                           likeFood: "ししゃも",
                           name: "ささみ",
                           photoURL: URL(string: "https://placehold.jp/500x500.png")!,
                           temperament: "かわいい"),
               NekoProfile(id: "2",
                           age: 20,
                           likeFood: "ながいも",
                           name: "しらす",
                           photoURL: URL(string: "https://placehold.jp/500x500.png")!,
                           temperament: "とてもかわいい")
             ])
    ]
  )
}

extension DependencyValues {
  var profileRepository: ProfileRepository {
    get { self[ProfileRepository.self] }
    set { self[ProfileRepository.self] = newValue }
  }
}
