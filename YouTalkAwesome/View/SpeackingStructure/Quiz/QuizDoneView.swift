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
            Color.background
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
                    .font(.system(size: 40, weight: .bold))
                
                Text("말하기 구조 학습을 완료했어요!")
                    .font(.system(size: 20))
                
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
                
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.main, lineWidth: 5)
                    .fill(Color.white)
                    .frame(width: 115, height: 46)
                    .overlay {
                        Text("\(speakingStructure.rawValue) +1")
                            .foregroundStyle(.main)
                            .font(.system(size: 20, weight: .semibold))
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
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18, weight: .semibold))
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
