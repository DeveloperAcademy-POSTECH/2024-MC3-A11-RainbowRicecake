//
//  StructureFlowView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/29/24.
//

import SwiftUI

struct StructureFlowView: View {
    var speakingStructure: SpeakingStructure
    
    @State var showExampleContents: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            LSWideCardView(speakingStructure: speakingStructure)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<speakingStructure.components.count, id: \.self) { index in
                        FlowComponentView(speakingStructure: speakingStructure, index: index, showExampleContents: $showExampleContents)
                    }
                }
                .padding()
                // 예시문장 열고 닫는 버튼
                Button(action: {
                    withAnimation {
                        showExampleContents.toggle()
                    }
                }) {
                    HStack {
                        Text(showExampleContents ? "예시닫기" : "예시보기")
                        Image(systemName: showExampleContents ? "chevron.up" : "chevron.down")
                    }
                    .foregroundColor(Color(hex:"898A8D"))
                }
            }
            
            Spacer()
            
            // 퀴즈로 넘어가는 버튼
            NavigationLink(destination: QuizView(lsStructure: speakingStructure)) {
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



#Preview {
    NavigationStack {
        StructureFlowView(speakingStructure: .prep)
    }
}
