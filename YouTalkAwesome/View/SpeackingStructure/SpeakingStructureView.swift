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


