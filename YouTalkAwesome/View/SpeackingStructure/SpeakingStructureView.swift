//
//  SpeakingStructureView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/29/24.
//

import SwiftUI

struct SpeakingStructureView: View {
    @StateObject private var router = Router.shared
    
    var body: some View {
        NavigationStack(path: $router.route) {
            ScrollView {
                VStack(spacing: 10){
                    HStack {
                        InstructionTextView(instructionKeyword : ["말하기 구조","학습"], verbalPart: ["를", "해보세요!"])
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 12)  {
                            ForEach (SpeakingStructure.allCases, id: \.self) { speakingStructure in
                                Button {
                                    router.setSelectedStructure(selection: speakingStructure)
                                    router.push(screen: .StructureFlow)
                                } label: {
                                    LSCardView(speakingStructure: speakingStructure)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                    .padding(.bottom, 22)
                }
                
                VStack(spacing: 32) {
                    VStack(spacing: 14) {
                        HStack {
                            ExampleTitleView(title: "청중의 마음을 움직인 연설 🎙️")
                            Spacer()
                        }
                        .padding(.leading, 20)
                        ScrollView(.horizontal) {
                            HStack(spacing: 16) {
                                ForEach(sampleSpeeches.filter { $0.category == "연설"}, id: \.self) { speech in
                                    Button {
                                        router.setSpeech(speech: speech)
                                        router.push(screen: .Speech)
                                    } label: {
                                        ExampleCardView(speech: speech, title: speech.title)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    VStack(spacing: 14) {
                        HStack {
                            ExampleTitleView(title: "CEO 인터뷰 ✍🏻")
                            Spacer()
                        }
                        .padding(.leading, 20)
                        ScrollView(.horizontal) {
                            HStack(spacing: 16) {
                                ForEach(sampleSpeeches.filter { $0.category == "CEO 인터뷰"}, id: \.self) { speech in
                                    NavigationLink(destination: SpeechView(speech: speech)) {
                                        ExampleCardView(speech: speech, title: speech.title)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
                .padding(.top, 24)
                .padding(.bottom, 40)
                .background(Color.bg)
            }
            .scrollIndicators(.hidden)
            .navigationDestination(for: ViewList.self) { list in
                router.pushView(screen: list)
            }
            
        }
        .navigationBarBackButtonHidden()
        
    }
}

#Preview {
    SpeakingStructureView()
}


