//
//  WritingComponentView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 8/1/24.
//

import SwiftUI

struct WritingComponentView: View {
    var color : Color
    var structureSection : StructureSection
    
    @Binding var textContent: String
    
    var isEndContent : Bool
    
    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .fill(structureSection.isScript ? color : Color.white)
                .stroke(color)
                .frame(width: 9, height: 9)
                .offset(y: 7)
            
            
            VStack(alignment: .leading) {
                
                Text(structureSection.topContent)
                    .customFont(.body1_bold)
                    .foregroundStyle(color)
                
                // 구조적 표현이 선택된 경우 e.g. Point, Reason, Attention etc
                if structureSection.isScript {
                    TextField("", text: $textContent, axis: .vertical)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .lineLimit(20)
                    // 비언어적 표현이 선택된 경우
                } else {
                    TextField("", text: $textContent, axis: .vertical)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .lineLimit(20)
                        .foregroundColor(Color.gray)
                }
            }
            
            Spacer()
        }
        .background(alignment: .leading) {
            if !isEndContent {
                GeometryReader { geometry in
                    Rectangle()
                        .foregroundColor(color)
                        .frame(width: 2, height: geometry.size.height + 40 )
                        .offset(x: 3, y: 7)
                }
            }
        }
        .padding()
        
    }
}

#Preview {
    
    VStack {
        WritingComponentView(
            color: SpeakingStructure.prep.color,
            structureSection: .init(
                topContent: "\(SpeakingStructure.prep.components[1]) (\(SpeakingStructure.prep.components_kor[1]))",
                bodyContent: "",
                isScript: true),
            textContent: .constant(""),
            isEndContent: false
        )
        WritingComponentView(
            color: SpeakingStructure.prep.color,
            structureSection: .init(
                topContent: "🫲",
                bodyContent: "",
                isScript: false),
            textContent: .constant(""),
            isEndContent: false
        )
        WritingComponentView(
            color: SpeakingStructure.prep.color,
            structureSection: .init(
                topContent: "\(SpeakingStructure.prep.components[1]) (\(SpeakingStructure.prep.components_kor[1]))",
                bodyContent: "",
                isScript: true),
            textContent: .constant(""),
            isEndContent: false
        )
        WritingComponentView(
            color: SpeakingStructure.prep.color,
            structureSection: .init(
                topContent: "\(SpeakingStructure.prep.components[1]) (\(SpeakingStructure.prep.components_kor[1]))",
                bodyContent: "",
                isScript: true),
            textContent: .constant(""),
            isEndContent: true
        )
    }
    
}
