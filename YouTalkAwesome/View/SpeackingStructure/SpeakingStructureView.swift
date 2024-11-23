//
//  SpeakingStructureView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/29/24.
//

import SwiftUI

struct SpeakingStructureView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var body: some View {
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
                                coordinator.push(.StructureFlow(structure: speakingStructure))
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
            .navigationBarBackButtonHidden()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    SpeakingStructureView()
}


