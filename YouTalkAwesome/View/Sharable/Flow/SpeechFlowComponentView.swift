//
//  SpeechComponentView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/31/24.
//

import SwiftUI

struct SpeechFlowComponentView: View {
    var speech: CaseSpeech
    var index: Int
    
    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .fill(Color.main)
                .frame(width: 9, height: 9)
                .offset(y: 7)
            VStack(alignment: .leading) {
                Text("\(speech.speakingStructure.components[index]) (\(speech.speakingStructure.components_kor[index]))")
                    .customFont(.title4_bold)
                    .foregroundStyle(Color.main)
                    .padding(.bottom, 10)
                Text("\(speech.content[index])")
                    .customFont(.body2_light2)
                    .padding(.bottom)
            }
        }
        .padding(.bottom)
        .background(alignment: .leading) {
            if index != speech.speakingStructure.components.count - 1 {
                Rectangle()
                    .foregroundColor(Color.main)
                    .frame(width: 3)
                    .offset(x: 3, y: 7)
            }
        }
    }
    
}
