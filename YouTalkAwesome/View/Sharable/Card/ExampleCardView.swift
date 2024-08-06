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
            
            LinearGradient(gradient: Gradient(colors: [Color.bk, Color.wh]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(0.85)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    LSStickerView(lsName: speech.speakingStructure.rawValue)
                }
                .padding(.top, 12)
                .padding(.trailing, 12)
                
                Spacer(minLength: 0)
                
                HStack {
                    Text(speech.title)
                        .customFont(.body1_bold)
                        .foregroundStyle(.wh)
                        .frame(width: 140, alignment: .leading)
                        .fixedSize(horizontal: true, vertical: true)
                    Spacer()
                }
                .padding(.bottom, 14)
                .padding(.leading, 14)
            }
            
            
            
        }
        .frame(width: 205, height: 128)
        
    }
}

#Preview {
    HStack  {
        ExampleCardView(speech: sampleSpeeches[0], title: "원인이 어려운 장애 극복하기")
        ExampleCardView(speech: sampleSpeeches[1], title: "원인이 어려운 장애 극복하기")
    }
    
}
