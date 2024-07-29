//
//  LogicalStructureView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/29/24.
//

import SwiftUI

struct SpeakingStructureView: View {
    struct ExampleData: Hashable {
        var logicalStructure : LogicalStructure
        var title : String
    }
    
    let speechExample : [ExampleData] = [
        ExampleData(logicalStructure: .prep, title: "스티프잡스\n스탠포드 졸업축사"),
        ExampleData(logicalStructure: .grow, title: "마틴 루터 킹의\n\"I Have a Dream\""),
    ]
    
    let interviewExample: [ExampleData] = [
        ExampleData(logicalStructure: .star, title: "원인파악이 어려운 장애 극복하기"),
        ExampleData(logicalStructure: .prep, title: "모든 취준생이 꼭 알아야하는 것"),
    ]
    
    var body: some View {
        ScrollView {
            HStack {
                InstructionTextView(instructionKeyword : ["말하기 구조","학습"], verbalPart: ["를", "해보세요!"])
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal) {
                HStack (spacing: 20)  {
                    ForEach (LogicalStructure.allCases, id: \.self) { logicalStructure in
                        LSCardView(logicalStructure: logicalStructure)
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
                        ForEach(speechExample, id: \.self) { example in
                            ExampleCardView(logicalStructure: example.logicalStructure, title: example.title)
                        }
                    }
                    .padding(.vertical)
                }
                
                HStack {
                    ExampleTitleView(title: "커리어 인터뷰 ✍🏻")
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(interviewExample, id: \.self) { example in
                            ExampleCardView(logicalStructure: example.logicalStructure, title: example.title)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .padding()
            .background(Color.background)
        }
    }
}

#Preview {
    SpeakingStructureView()
}
