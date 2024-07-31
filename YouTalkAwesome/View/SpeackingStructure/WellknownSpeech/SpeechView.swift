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
                    .foregroundStyle(Color(hex: "51D7A7"))
                    .fontWeight(.bold)
            }
            // 대본쓰기로 넘어가는 버튼
            NavigationLink(destination: ScriptWritingView()) {
                RoundedRectangle(cornerRadius: 18)
                    .foregroundStyle(Color(hex: "51D7A7"))
                    .frame(width: 353, height: 54)
                    .overlay(
                        Text("\(speech.speakingStructure.rawValue) 기반 대본 쓰기")
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                    )
            }
        }
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
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(0.7)
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Spacer()
                    LSStickerView(lsName: speech.speakingStructure.rawValue)
                    Text(speech.title)
                        .font(.system(size: 24))
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .frame(width: 200, alignment: .leading)
                    HStack {
                        Text("\(speech.category) | \(speech.date)")
                            .font(.system(size: 12))
                            .foregroundStyle(.white)
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
    let height: CGFloat = 142 //여기 flexible 하게 해야함
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color(hex: "51D7A7"), lineWidth: 2)
            .fill(Color(hex: "F0F8F5"))
            .frame(width: width, height: height)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: "51D7A7"))
                    .offset(x: 5, y: 5)
            }
            .overlay {
                HStack {
                    VStack(alignment: .leading) {
                        if speakingStructure != nil || speech != nil {
                            Label(topContent, systemImage: speakingStructure != nil ? "checkmark.circle.fill" : "square.and.pencil")
                                .foregroundStyle(Color(hex: "51D7A7"))
                                .fontWeight(.bold)
                                .padding(.bottom, 3)
                                .font(.system(size: 16))
                        }
                        Text(bodyContent)
                            .foregroundStyle(.gray)
                            .font(.system(size: 15))
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
