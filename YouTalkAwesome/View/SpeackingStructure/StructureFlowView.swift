//
//  StructureFlowView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/29/24.
//

import SwiftUI

struct StructureFlowView: View {
    var speakingStructure: SpeakingStructure
    
    @State var showExampleContents: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                //임시로 이미지로 넣음
                LSWideCardView(speakingStructure: speakingStructure)
                
                VStack(alignment: .leading) {
                    ForEach(0..<speakingStructure.components.count, id: \.self) { index in
                        HStack(alignment: .top) {
                            Circle()
                                .fill(speakingStructure.color)
                                .frame(width: 8, height: 8)
                            VStack(alignment: .leading) {
                                Text("\(speakingStructure.components[index]) (\(speakingStructure.components_kor[index]))")
                                    .foregroundStyle(speakingStructure.color)
                                    .fontWeight(.bold)
                                Text("\(speakingStructure.componentDescriptions[index])")
                                    .foregroundStyle(Color(hex: "898A8D"))
                                if showExampleContents {
                                    RoundedRectangle(cornerRadius: 8)
//                                        .border(Color(hex: "898A8D"), width: 1)
                                        .foregroundStyle(Color.white)
                                        .overlay(
                                            VStack(alignment: .leading) {
                                                Text("\(speakingStructure.componentExamples[index])")
                                            }
                                        )
                                }
                            }
                            Spacer()
                        }
                    }
                }
                .padding()
                
                //예시문장 열고 닫는 버튼
                Button(action: {
                    showExampleContents.toggle()
                }) {
                    HStack {
                        if showExampleContents {
                            Text("예시닫기")
                            Image(systemName: "chevron.up")
                        } else {
                            Text("예시보기")
                            Image(systemName: "chevron.down")
                        }
                    }
                    .foregroundColor(Color(hex:"898A8D"))
                }
                
                Spacer()
                
                //퀴즈로 넘어가는 버튼
                NavigationLink(destination: StructureQuizView()) {
                    RoundedRectangle(cornerRadius: 18)
                        .foregroundStyle(Color(hex: "51D7A7"))
                        .frame(width: 353, height: 54)
                        .overlay(
                            Text("흐름 학습하기")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white)
                        )
                }
                
            }
            .padding()
            .background(Color(hex: "F1F3F6"))
        }
    }
}

#Preview {
    StructureFlowView(speakingStructure: .prep)
}
