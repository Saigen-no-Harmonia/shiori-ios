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
    VStack(alignment: .leading) {
      KFImage(profile.photoURL)
        .resizable()
        .frame(width: 300, height: 300)
        .aspectRatio(contentMode: .fit)
      Title3BoldText(profile.firstNameKana + " " + profile.lastNameKana)
      TitleBoldText(profile.firstName + " " + profile.lastName)
        .padding(.bottom, 12)
      Grid(verticalSpacing: 8) {
        GridRow {
          HeadlineText("何と呼ばれているか")
          BodyText(profile.nickName)
        }
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
          HeadlineText("好きなラーメン")
          BodyText(profile.ramen)
        }
        GridRow {
          HeadlineText("相手の好きなところ")
          BodyText(profile.likeBy)
        }
      }
    }
    .padding(.horizontal, 24)
  }
}

#Preview {
  PresenterProfileView(
    profile: ProfileRepository.mock.families.first!.presenter
  )
}
