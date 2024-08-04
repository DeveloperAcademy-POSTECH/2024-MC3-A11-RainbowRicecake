//
//  SpeechView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/31/24.
//

import SwiftUI

struct SpeechView: View {
    let speech: WellKnownSpeech
    
    var body: some View {
        ScrollView {
            VStack() {
                SpeechTitleView(speech: speech)
                    .padding(.top, 54)
                VStack(spacing: 24){
                    SubCardView(speakingStructure: speech.speakingStructure)
                    SubCardView(speech: speech)
                }
                .padding(.top, 16)
                .padding(.trailing, 2)
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<speech.speakingStructure.components.count, id: \.self) { index in
                        SpeechFlowComponentView(speakingStructure: speech.speakingStructure, speech: speech, index: index)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 36)
            }
            .padding(.bottom, 100)
            
            // 말하기구조 학습하기로 넘어가는 버튼
            Button {
                Router.shared.setSelectedStructure(selection: self.speech.speakingStructure)
                Router.shared.push(screen: .StructureFlow)
            } label: {
                Text("\(speech.speakingStructure.rawValue) 학습하기")
                    .customFont(.body1_bold)
                    .foregroundStyle(Color.main)
            }
            .padding(.bottom, 10)
            
            // 대본쓰기로 넘어가는 버튼
            Button {
                Router.shared.setSelectedStructure(selection: self.speech.speakingStructure)
                Router.shared.push(screen: .ContentWritingStartWithoutTopic)
            } label: {
                RoundedRectangle(cornerRadius: 18)
                    .foregroundStyle(Color.main)
                    .frame(width: 353, height: 54)
                    .overlay(
                        Text("\(speech.speakingStructure.rawValue) 기반 대본 쓰기")
                            .customFont(.body1_bold)
                            .foregroundStyle(Color.wh)
                    )
            }
            .padding(.bottom, 120)
        }
        
        .ignoresSafeArea()
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
                        Text("\(speech.category)  |  \(speech.date)")
                            .customFont(.caption2_light)
                            .foregroundStyle(.wh)
                    }
                }
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.bottom, 16)
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
    
    let width: CGFloat = 356
    let height: CGFloat = 142 //TODO: 여기 flexible 하게 해야함
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color.main, lineWidth: 4)
            .fill(Color.bg)
            .frame(width: width, height: height)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.main)
                    .offset(x: 4, y: 6)
            }
            .overlay {
                HStack {
                    VStack(alignment: .leading) {
                        if speakingStructure != nil || speech != nil {
                            Label(topContent, systemImage: speakingStructure != nil ? "checkmark.circle.fill" : "square.and.pencil")
                                .customFont(.body3_bold)
                                .foregroundStyle(Color.main)
                                .padding(.bottom, 12)
                        }
                        Text(bodyContent)
                            .customFont(.body3_light)
                            .foregroundStyle(.gray2)
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 12)
                }
            }
    }
}


#Preview {
    NavigationStack {
        SpeechView(speech: sampleSpeeches[1])
    }
}
