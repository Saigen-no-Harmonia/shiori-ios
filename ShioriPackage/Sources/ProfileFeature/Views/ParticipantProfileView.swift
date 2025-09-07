//
//  ParticipantProfileView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/03.
//

import Kingfisher
import SwiftUI
import Utility

struct ParticipantProfileView: View {
  let profile: ParticipantProfile

  var body: some View {
    GroupBox {
      VStack(alignment: .leading) {
        HStack {
          KFImage(profile.photoURL)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: 150, maxHeight: 150)
            .clipped()
            .border(Colors.tertiary.color, width: 1)
          VStack {
            CalloutBoldText(profile.firstNameKana + " " + profile.lastNameKana)
            TitleBoldText(profile.firstName + " " + profile.lastName)
          }
        }
        .padding(.bottom, 16)
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
          .padding(.bottom, 8)
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
        QuestionTitleView(text: "好きな食べ物")
          .padding(.bottom, 8)
        BodyText(profile.likeFood)
          .padding(.bottom, 10)
          .padding(.leading, 36)
        Divider()
          .padding(.bottom, 8)
        QuestionTitleView(text: "ひとこと")
          .padding(.bottom, 8)
        BodyText(profile.message)
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
  ParticipantProfileView(
    profile: ProfileRepository.mock.families.first!.participants.first!
  )
}
