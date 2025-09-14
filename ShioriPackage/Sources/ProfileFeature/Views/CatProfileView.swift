//
//  CatProfileView.swift
//  ShioriPackage
//
//  Created by canacel on 2025/08/03.
//

import Kingfisher
import SwiftUI
import Utility

struct CatProfileView: View {
  let profile: CatProfile

  var body: some View {
    GroupBox {
      VStack(alignment: .leading) {
        HStack(spacing: 24) {
          KFImage(profile.photoURL)
            .placeholder {
              ShioriProgressView()
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .border(Colors.tertiary.color, width: 1)
          Title2BoldText(profile.name)
        }
        .padding(.bottom, 16)
        QuestionTitleView(text: "年齢")
          .padding(.bottom, 8)
        BodyText(String(profile.age) + "歳")
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
        QuestionTitleView(text: "性格")
          .padding(.bottom, 8)
        BodyText(profile.temperament)
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
  CatProfileView(
    profile: ProfileRepository.mock.families[1].cats!.first!
  )
}
