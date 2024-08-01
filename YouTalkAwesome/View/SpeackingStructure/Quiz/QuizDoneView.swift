//
//  QuizDoneView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/30/24.
//

import SwiftUI

struct QuizDoneView: View {
    @StateObject var practicePointsViewModel = PracticePointsViewModel()
    @State private var isAnimating = false
    var speakingStructure: SpeakingStructure
    
    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()
            
            Circle()
                .fill(.white)
                .blur(radius: 30)
            
            Image("Glitter")
                .offset(y: -80)
                .scaleEffect(isAnimating ? 1 : 0.3)
                .onAppear {
                    withAnimation(.bouncy, {
                        isAnimating = true
                    })
                }
            
            VStack {
                Spacer()
                Text(speakingStructure.rawValue)
                    .customFont(.point1)
                    .padding()
                
                Text("말하기 구조 학습을 완료했어요!")
                    .customFont(.title4_bold)
                
                Image("\(speakingStructure.rawValue)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 165, height: 165)
                    .scaleEffect(isAnimating ? 1 : 0.3)
                    .onAppear {
                        withAnimation(.bouncy, {
                            isAnimating = true
                        })
                    }
                
                //TODO: 여기 Figma 디자인이랑 조금 다름 추후 논의 필요!
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.main, lineWidth: 5)
                    .fill(Color.white)
                    .frame(width: 115, height: 46)
                    .overlay {
                        Text("\(speakingStructure.rawValue) +1")
                            .customFont(.point5)
                            .foregroundStyle(.main)
                    }
                    .padding(.top, 70)
                
                Spacer()
                
                //TODO: QuizDoneView 에서 학습 종료시 홈 화면으로 안돌아감
                //버튼 안에 액션이 있으면 링크가 안되나?
                NavigationLink(destination: SpeakingStructureView()) {
                    Button {
                        practicePointsViewModel.addPoint(key: speakingStructure.rawValue)
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
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        QuizDoneView(speakingStructure: .prep)
    }
}
