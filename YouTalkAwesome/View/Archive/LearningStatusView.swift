//
//  LearningStatusView.swift
//  YouTalkAwesome
//
//  Created by 최하늘 on 8/2/24.
//

import SwiftUI

struct LearningStatusView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 32) {
                Text("나의 말하기 구조 학습 현황")
                    .customFont(.title4_bold)
                    .padding(.top, 16)
                
                VStack(spacing: 32) {
                    ForEach (SpeakingStructure.allCases, id: \.self) { speakingStructure in
                        LSWideCardView(speakingStructure: speakingStructure, height: 152)
                            .padding(.trailing, 6)
                    }
                }
            }
            .padding()
        }
        .padding(.horizontal, 20)
        .background(.gray6)
    }
}


#Preview {
    LearningStatusView()
}
