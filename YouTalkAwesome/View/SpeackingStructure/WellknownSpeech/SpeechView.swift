//
//  SpeechView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/31/24.
//

import SwiftUI

struct SpeechView: View {
    var speech: WellKnownSpeech
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                SpeechTitleView(speech: speech)
                SubCardView(speakingStructure: speech.speakingStructure)
                SubCardView(speech: speech)
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<speech.speakingStructure.components.count, id: \.self) { index in
                        SpeechFlowComponentView(speakingStructure: speech.speakingStructure, speech: speech, index: index)
                    }
                }
                .padding()
            }
            // 말하기구조 학습하기로 넘어가는 버튼
            NavigationLink(destination: StructureFlowView(speakingStructure: speech.speakingStructure)) {
                Text("\(speech.speakingStructure.rawValue) 학습하기")
                    .customFont(.body1_bold)
                    .foregroundStyle(Color.main)
            }
            // 대본쓰기로 넘어가는 버튼
            NavigationLink(destination: ScriptWritingView()) {
                RoundedRectangle(cornerRadius: 18)
                    .foregroundStyle(Color.main)
                    .frame(width: 353, height: 54)
                    .overlay(
                        Text("\(speech.speakingStructure.rawValue) 기반 대본 쓰기")
                            .customFont(.body1_bold)
                            .foregroundStyle(Color.wh)
                    )
            }
        }
        .scrollIndicators(.hidden)
        .toolbarRole(.editor)
    }
}

struct SpeechTitleView: View {
    var speech: WellKnownSpeech
    
    var body: some View {
        ZStack {
            Image(speech.imageName)
                .resizable()
                .scaledToFill()
            LinearGradient(gradient: Gradient(colors: [Color.bk, Color.wh]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(0.7)
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Spacer()
                    LSStickerView(lsName: speech.speakingStructure.rawValue)
                    Text(speech.title)
                        .customFont(.title3_bold)
                        .foregroundStyle(.wh)
                        .frame(width: 200, alignment: .leading)
                    HStack {
                        Text("\(speech.category) | \(speech.date)")
                            .customFont(.caption2_light)
                            .foregroundStyle(.wh)
                    }
                }
                Spacer()
            }
            .padding()
        }
        .frame(width: 393, height: 229)
    }
}

struct SubCardView: View {
    var speakingStructure: SpeakingStructure?
    var speech: WellKnownSpeech?
    
    var topContent: String {
        if let structure = speakingStructure {
            return "\(structure.rawValue)의 효과"
        } else {
            return "요약"
        }
    }
    
    var bodyContent: String {
        if let structure = speakingStructure {
            return structure.effect
        } else if let speech = speech {
            return speech.summary
        } else {
            return ""
        }
    }
    
    let width: CGFloat = 361
    let height: CGFloat = 142 //TODO: 여기 flexible 하게 해야함
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.main, lineWidth: 2)
            .fill(Color.bg)
            .frame(width: width, height: height)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.main)
                    .offset(x: 5, y: 5)
            }
            .overlay {
                HStack {
                    VStack(alignment: .leading) {
                        if speakingStructure != nil || speech != nil {
                            Label(topContent, systemImage: speakingStructure != nil ? "checkmark.circle.fill" : "square.and.pencil")
                                .customFont(.body3_bold)
                                .foregroundStyle(Color.main)
                                .padding(.bottom, 3)
                        }
                        Text(bodyContent)
                            .customFont(.body3_light)
                            .foregroundStyle(.gray2)
                    }
                    .padding(12)
                    Spacer()
                }
            }
    }
}


#Preview {
    NavigationStack {
        SpeechView(speech: sampleSpeeches[0])
    }
}
