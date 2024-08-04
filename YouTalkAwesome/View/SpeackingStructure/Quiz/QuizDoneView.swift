//
//  QuizDoneView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/30/24.
//

import SwiftUI

struct QuizDoneView: View {
    var isRepeat: Bool
    @StateObject var practicePointsViewModel = PracticePointsDataHandler.shared
    var isRepeat: Bool
    @State private var isAnimating = false
    var speakingStructure: SpeakingStructure
    
    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()
            
            Circle()
                .fill(.wh)
                .blur(radius: 30)
            
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
                
                Spacer()
                
                if !isRepeat {
                    ZStack(alignment: .leading){
                        Capsule()
                            .frame(width: 305, height: 20)
                            .foregroundColor(.gray6)
                        Capsule()
                            .frame(width: 30.5 * CGFloat(practicePointsViewModel.getPoint(key: speakingStructure.rawValue)), height: 20)
                            .foregroundColor(speakingStructure.color)
                    }
                    .overlay(
                        HStack(spacing: 4) {
                            let point = practicePointsViewModel.getPoint(key: speakingStructure.rawValue)
                            let color: Color = point < 5 ? .gray3 : .white
                            
                            Text("\(point)")
                                .foregroundColor(color)
                            Text("/")
                                .foregroundColor(color)
                            Text("10")
                                .foregroundColor(point < 6 ? .gray3 : .white)
                        }
                            .customFont(.caption1_bold)
                    )
                }
                
                Spacer()
                
                NavigationLink(destination: QuizView(lsStructure: speakingStructure, isRepeat: true)) {
                    HStack {
                        Text("복습하기")
                            .customFont(.body1_light)
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .foregroundColor(.main)
                }
                
                Button {
                    Router.shared.popToRootView()
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
        QuizDoneView(isRepeat: true, speakingStructure: .prep)
    }
}
