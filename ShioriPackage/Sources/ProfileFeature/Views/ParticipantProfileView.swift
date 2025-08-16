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
            .frame(width: 150, height: 150)
            .aspectRatio(contentMode: .fit)
          VStack {
            Title3BoldText(profile.firstNameKana + " " + profile.lastNameKana)
            TitleBoldText(profile.firstName + " " + profile.lastName)
          }
        }
        .padding(.bottom, 16)
        Grid(verticalSpacing: 8) {
          GridRow {
            HeadlineText("誕生日")
            BodyText(profile.birthDate)
          }
          GridRow {
            HeadlineText("出身地")
            BodyText(profile.birthPlace)
          }
          GridRow {
            HeadlineText("お仕事")
            BodyText(profile.job)
          }
          GridRow {
            HeadlineText("趣味")
            BodyText(profile.hobby)
          }
          GridRow {
            HeadlineText("好きな食べ物")
            BodyText(profile.likeFood)
          }
          GridRow {
            HeadlineText("ひとこと")
            BodyText(profile.message)
          }
        }
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
