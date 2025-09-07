//
//  PresenterProfileView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/02.
//

import Kingfisher
import SwiftUI
import Utility

struct PresenterProfileView: View {
  let profile: PresenterProfile

  var body: some View {
    GroupBox {
      VStack(alignment: .leading) {
        KFImage(profile.photoURL)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .clipped()
          .border(Colors.tertiary.color, width: 1)
        CalloutBoldText(profile.firstNameKana + " " + profile.lastNameKana)
        TitleBoldText(profile.firstName + " " + profile.lastName)
          .padding(.bottom, 12)
        QuestionTitleView(text: "何と呼ばれているか")
          .padding(.bottom, 8)
        BodyText(profile.nickName)
          .padding(.bottom, 10)
          .padding(.leading, 36)
        Divider()
          .padding(.bottom, 8)
        QuestionTitleView(text: "誕生日")
          .padding(.bottom, 8)
        BodyText(DateFormatter.yearMonthDay.string(from: profile.birthDate))
          .padding(.bottom, 10)
          .padding(.leading, 36)
        Divider()
          .padding(.bottom, 8)
        QuestionTitleView(text: "出身地")
          .padding(.bottom, 8)
        BodyText(profile.birthPlace)
          .padding(.bottom, 10)
          .padding(.leading, 36)
        Divider()
          .padding(.bottom, 6)
        QuestionTitleView(text: "お仕事")
          .padding(.bottom, 8)
        BodyText(profile.job)
          .padding(.bottom, 10)
          .padding(.leading, 36)
        Divider()
          .padding(.bottom, 8)
        QuestionTitleView(text: "趣味")
          .padding(.bottom, 8)
        BodyText(profile.hobby)
          .padding(.bottom, 10)
          .padding(.leading, 36)
        Divider()
          .padding(.bottom, 8)
        QuestionTitleView(text: "好きなラーメン")
          .padding(.bottom, 8)
        BodyText(profile.ramen)
          .padding(.bottom, 10)
          .padding(.leading, 36)
        Divider()
          .padding(.bottom, 8)
        QuestionTitleView(text: "相手の好きなところ")
          .padding(.bottom, 8)
        BodyText(profile.likeBy)
          .padding(.bottom, 10)
          .padding(.leading, 36)
      }
    }
    .groupBoxStyle(ProfileGroupBoxStyle())
    .padding(.horizontal, 24)
    .padding(.vertical, 24)
  }
}

#Preview {
  PresenterProfileView(
    profile: ProfileRepository.mock.families.first!.presenter
  )
}
