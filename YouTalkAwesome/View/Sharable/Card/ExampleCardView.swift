//
//  ExampleCardView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/29/24.
//

import SwiftUI

struct ExampleCardView: View {
    var speech: WellKnownSpeech
    var title: String
    
    var body: some View {
        
        ZStack {
            Image(speech.imageName)
                .resizable()
                .frame(width: 205, height: 128)
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(0.85)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Spacer()
                    LSStickerView(lsName: speech.speakingStructure.rawValue)
                }
                HStack {
                Text(speech.title)
                    .customFont(.body1_bold)
                    .foregroundStyle(.white)
                    .frame(width: 140, alignment: .leading)
                    Spacer()
                }
            }
            .padding()
        }
        .frame(width: 205, height: 128)
    }
}

#Preview {
    ExampleCardView(speech: sampleSpeeches[0], title: "원인이 어려운 장애 극복하기")
}
