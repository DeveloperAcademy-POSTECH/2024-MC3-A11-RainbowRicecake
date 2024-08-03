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
            Text("말하기 구조를 학습해보아요")
                .customFont(.title2_bold)
            LSWideCardView(speakingStructure: speakingStructure, height: 120)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<speakingStructure.components.count, id: \.self) { index in
                        FlowComponentView(speakingStructure: speakingStructure, index: index, showTextBox: $showExampleContents)
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
                    .foregroundColor(Color.gray3)
                }
            }
            .scrollIndicators(.hidden)
            Spacer()
            
            NavigationLink(destination: QuizView(lsStructure: speakingStructure)) {
                RoundedRectangle(cornerRadius: 18)
                    .foregroundStyle(Color.main)
                    .frame(width: 353, height: 54)
                    .overlay(
                        Text("흐름 학습하기")
                            .fontWeight(.bold)
                            .foregroundStyle(Color.wh)
                    )
            }
        }
        .padding()
        .background(Color.gray6)
        .toolbarRole(.editor)
    }
    
}

#Preview {
    NavigationStack {
        StructureFlowView(speakingStructure: .grow)
    }
}
