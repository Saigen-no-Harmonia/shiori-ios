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
        HStack {
          KFImage(profile.photoURL)
            .resizable()
            .frame(width: 150, height: 150)
            .aspectRatio(contentMode: .fit)
          TitleBoldText(profile.name)
        }
        .padding(.bottom, 16)
        Grid(verticalSpacing: 8) {
          GridRow {
            HeadlineText("年齢")
            BodyText(String(profile.age))
          }
          GridRow {
            HeadlineText("好きな食べ物")
            BodyText(profile.likeFood)
          }
          GridRow {
            HeadlineText("性格")
            BodyText(profile.temperament)
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
  CatProfileView(
    profile: ProfileRepository.mock.families[1].cats!.first!
  )
}
