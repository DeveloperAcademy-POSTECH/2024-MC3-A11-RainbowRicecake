//
//  SpeakingStructureView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/29/24.
//

import SwiftUI

struct SpeakingStructureView: View {
    struct ExampleData: Hashable {
        var speakingStructure : SpeakingStructure
        var title : String
    }
    
    let speechExample : [ExampleData] = [
        ExampleData(speakingStructure: .prep, title: "스티프잡스\n스탠포드 졸업축사"),
        ExampleData(speakingStructure: .grow, title: "마틴 루터 킹의\n\"I Have a Dream\""),
    ]
    
    let interviewExample: [ExampleData] = [
        ExampleData(speakingStructure: .star, title: "원인파악이 어려운 장애 극복하기"),
        ExampleData(speakingStructure: .prep, title: "모든 취준생이 꼭 알아야하는 것"),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    InstructionTextView(instructionKeyword : ["말하기 구조","학습"], verbalPart: ["를", "해보세요!"])
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20)  {
                        ForEach (SpeakingStructure.allCases, id: \.self) { speakingStructure in
                            NavigationLink(destination: StructureFlowView(speakingStructure: speakingStructure)) {
                                LSCardView(speakingStructure: speakingStructure)
                            }
                        }
                    }
                }
                .padding(.bottom)
                
                VStack {
                    HStack {
                        ExampleTitleView(title: "청중의 마음을 움직인 연설🎙️")
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(sampleSpeeches, id: \.self) { speech in
                                //TODO: NavigationLink 적용하면 ExampleCardView 의 alignment 가 적용이 안됨..WHY??
                                NavigationLink(destination: SpeechView(speech: speech)) {
                                    ExampleCardView(speech: speech, title: speech.title)
                                }
                            }
                        }
                        .padding(.top, 9)
                        .padding(.bottom, 17)
                    }
                    
                    HStack {
                        ExampleTitleView(title: "커리어 인터뷰 ✍🏻")
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(sampleSpeeches, id: \.self) { speech in
                                //TODO: NavigationLink 적용하면 ExampleCardView 의 alignment 가 적용이 안됨..왜지??
                                NavigationLink(destination: SpeechView(speech: speech)) {
                                    ExampleCardView(speech: speech, title: speech.title)
                                }
                            }
                        }
                        .padding(.top, 9)
                        .padding(.bottom, 17)
                    }
                }
                .padding()
                .background(Color.background)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SpeakingStructureView()
}
