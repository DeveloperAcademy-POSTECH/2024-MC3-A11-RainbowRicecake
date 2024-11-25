//
//  StructureSectionView.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/30/24.
//

import SwiftUI

struct StructureSectionView: View {
    let speakingStructure: SpeakingStructure
    let topContent: String
    let bottomContent: String
    let isScript: Bool
    
    var body: some View {
        ZStack {
            if self.isScript {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 0.66)
                    .foregroundStyle(.gray5)
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.gray6)
            }
            
            VStack(spacing: 4) {
                //TODO: 말하기 구조에 따른 색상 변경 추후 필요할 듯 합니다~
                Text(topContent)
                    .customFont(.body1_bold)
                    .foregroundStyle(speakingStructure.color)
                    .padding(.top, 12)
                
                Text(bottomContent)
                    .customFont(.body2_light)
                    .foregroundStyle( isScript ? .black : .gray2)
                    .padding(10)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

#Preview {
    StructureSectionView(speakingStructure: .psb, topContent: "topContent", bottomContent: "bottomContent", isScript: true)
}
