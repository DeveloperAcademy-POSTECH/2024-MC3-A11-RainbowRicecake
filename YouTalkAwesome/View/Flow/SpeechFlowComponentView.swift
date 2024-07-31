//
//  SpeechComponentView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/31/24.
//

import SwiftUI

struct SpeechFlowComponentView: View {
    var speakingStructure: SpeakingStructure
    var speech: WellKnownSpeech
    var index: Int
    
    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .fill(Color(hex: "51D7A7"))
                .frame(width: 9, height: 9)
                .offset(y: 7)
            VStack(alignment: .leading) {
                Text("\(speakingStructure.components[index]) (\(speakingStructure.components_kor[index]))")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: "51D7A7"))
                    .padding(.bottom, 10)
                
                Text("\(speech.content[index])")
                    .font(.system(size: 17))
                    .padding(.bottom)
            }
        }
        .background(alignment: .leading) {
            if index != speakingStructure.components.count - 1 {
                Rectangle()
                    .foregroundColor(Color(hex: "51D7A7"))
                    .frame(width: 3)
                    .offset(x: 3, y: 7)
            }
        }
    }
    
}

#Preview {
    SpeechFlowComponentView(speakingStructure: .aida, speech: sampleSpeeches[0], index: 1)
}
