//
//  SpeakingStructureView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/29/24.
//

import SwiftUI

struct SpeakingStructureView: View {
    @EnvironmentObject private var coordinator: AppCoordinator

    let preparedSituation = [
        "나에게 모두 이목집중 👀","한 방 터뜨리기 👊🏻","날카로운 상황 분석 📈","내 잠재력 어필하기 💫", "깔끔 요약정리 ✍🏻", "내 말에 설득당할 걸? 😎", "멋진 성장 스토리 🍀","현재 문제점 진단하기 🦔", "나의 경험 어필하기 🤓", "해결책 제시하기 💡", "문제해결 능력 어필⚡️", "생생하게 상황 묘사 🌼"
    ]

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
    
    @ViewBuilder
    func makeSituationCard(_ situation: String) -> some View {
        Text(situation)
            .customFont(.body3_light)
            .frame(height: 16)
            .background {
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray6)
                        .frame(width: geometry.size.width + 15, height: 44)
                        .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                }
            }
            .onTapGesture {
            }
    }
    
    private func evaluateSituation(text: String) -> SpeakingStructure {
        switch text {
        case "깔끔 요약정리 ✍🏻", "내 말에 설득당할 걸? 😎":
            return .prep
        case "나의 경험 어필하기 🤓", "멋진 성장 스토리 🍀":
            return .star
        case "내 잠재력 어필하기 💫", "날카로운 상황 분석 📈":
            return .grow
        case "한 방 터뜨리기 👊🏻", "나에게 모두 이목집중 👀":
            return .aida
        default:
            return .psb
        }
    }
}

#Preview {
    SpeakingStructureView()
}


