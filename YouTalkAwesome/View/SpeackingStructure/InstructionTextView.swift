//
//  InstructionTextView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/29/24.
//

import SwiftUI

struct InstructionTextView: View {
    
    var instructionKeyword: [String]
    var verbalPart : [String]
    
    var body: some View {
        VStack (alignment: .leading) {
            ForEach(0..<2) { index in
                HStack (spacing: 0) {
                    Text(instructionKeyword[index])
                        .foregroundStyle(.main)
                    Text(verbalPart[index])
                }
                .customFont(.title1_bold)
            }
        }
        
    }
}

#Preview {
    InstructionTextView(instructionKeyword : ["말하기 구조","학습"], verbalPart: ["를", "해보세요!"])
}
