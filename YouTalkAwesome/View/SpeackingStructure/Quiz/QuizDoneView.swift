//
//  QuizDoneView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/30/24.
//

import SwiftUI

struct QuizDoneView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var isRepeat: Bool
    @StateObject var practicePointsViewModel = PracticePointsDataHandler.shared
    @State private var isAnimating = false
    var speakingStructure: SpeakingStructure
    
    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()
            
            Circle()
                .fill(.wh)
                .blur(radius: 20)
                .frame(width: 560, height: 560)
            
            Image("\(speakingStructure.rawValue)-confetti")
                .resizable()
                .scaledToFit()
                .frame(width: 450)
                .offset(y: -80)
                .scaleEffect(isAnimating ? 1 : 0.3)
                .onAppear {
                    withAnimation(.bouncy(duration: 0.5), {
                        isAnimating = true
                    })
                }
            
            VStack {
                Spacer()
                VStack {
                    HStack(alignment: .bottom, spacing: 2) {
                        Text(speakingStructure.rawValue)
                            .customFont(.point1)
                        if !isRepeat {
                            Text("+1")
                                .font(.custom("Rubik", size: 24))
                                .fontWeight(.medium)
                                .padding(.bottom, 5)
                        }
                    }
                    
                    Text("말하기 구조 학습을 완료했어요!")
                        .customFont(.body1_bold)
                    
                    Image("\(speakingStructure.rawValue)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 165, height: 165)
                        .scaleEffect(isAnimating ? 1 : 0.3)
                        .onAppear {
                            withAnimation(.bouncy(duration: 1), {
                                isAnimating = true
                            })
                        }
                }
                .padding(.top, 50)
                Spacer()
                
                if !isRepeat {
                    ZStack(alignment: .leading) {
                        Capsule()
                            .frame(width: 305, height: 20)
                            .foregroundColor(.gray6)
                        
                        if practicePointsViewModel.getPoint(key: speakingStructure.rawValue) != 0 {
                            Capsule()
                                .frame(width: 305, height: 20)
                                .foregroundStyle(speakingStructure.color.gradient.shadow(.inner(color: .white.opacity(0.7), radius: 3)))
                        }
                    }
                    .padding(.bottom, 2)
                    .overlay(
                        HStack(spacing: 4) {
                            // 게이지가 절반이 넘어갈 때 색깔의 분기점이 생기기 때문에 경우 나눠서 색 지정 (지금은 1만..)
                            Text("\(practicePointsViewModel.getPoint(key: speakingStructure.rawValue))")
                                .foregroundColor(practicePointsViewModel.getPoint(key: speakingStructure.rawValue) == 1 ? .white : .gray3)
                            Text("/")
                                .foregroundColor(practicePointsViewModel.getPoint(key: speakingStructure.rawValue) == 1 ? .white : .gray3)
                            Text("1")
                                .foregroundColor(practicePointsViewModel.getPoint(key: speakingStructure.rawValue) == 1 ? .white : .gray3)
                        }
                            .customFont(.caption1_bold)
                    )
                }
                
                Spacer()
                
                Button {
                    coordinator.push(.Quiz(structure: speakingStructure, isRepeat: true))
                } label: {
                    HStack {
                        Text("복습하기")
                            .customFont(.body1_medium)
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .foregroundColor(.main)
                }
                .padding(.bottom, 12)
                
                Button {
                    coordinator.popToRoot()
                } label: {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.main)
                        .frame(width: 353, height: 54)
                        .overlay {
                            Text("학습 종료하기")
                                .customFont(.body1_bold)
                                .foregroundStyle(.white)
                        }
                }
            }
        }
        .onAppear {
            if !isRepeat {
                practicePointsViewModel.addPoint(key: speakingStructure.rawValue)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        QuizDoneView(isRepeat: false, speakingStructure: .prep)
    }
}
