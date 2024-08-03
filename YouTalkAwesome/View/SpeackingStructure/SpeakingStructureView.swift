//
//  SpeakingStructureView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/29/24.
//

import SwiftUI

struct SpeakingStructureView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    InstructionTextView(instructionKeyword : ["말하기 구조","학습"], verbalPart: ["를", "해보세요!"])
                    Spacer()
                }
                .padding([.top,.horizontal])
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20)  {
                        ForEach (SpeakingStructure.allCases, id: \.self) { speakingStructure in
                            NavigationLink(destination: StructureFlowView(speakingStructure: speakingStructure)) {
                                LSCardView(speakingStructure: speakingStructure)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(.bottom)
                
                VStack {
                    HStack {
                        ExampleTitleView(title: "청중의 마음을 움직인 연설🎙️")
                        Spacer()
                    }
                    .padding([.top,.horizontal], 10)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(sampleSpeeches.filter { $0.category == "연설"}, id: \.self) { speech in
                                NavigationLink(destination: SpeechView(speech: speech)) {
                                    ExampleCardView(speech: speech, title: speech.title)
                                        .padding(.leading, 10)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    
                    HStack {
                        ExampleTitleView(title: "커리어 인터뷰 ✍🏻")
                        Spacer()
                    }
                    .padding([.top,.horizontal], 10)
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(sampleSpeeches.filter { $0.category == "커리어 인터뷰"}, id: \.self) { speech in
                                NavigationLink(destination: SpeechView(speech: speech)) {
                                    ExampleCardView(speech: speech, title: speech.title)
                                        .padding(.leading, 10)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                .background(Color.bg)
            }
            .scrollIndicators(.hidden)

        }
        .navigationBarBackButtonHidden()

    }
}

#Preview {
    SpeakingStructureView()
}


