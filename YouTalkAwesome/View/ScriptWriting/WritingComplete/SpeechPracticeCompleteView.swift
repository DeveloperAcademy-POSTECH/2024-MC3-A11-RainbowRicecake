//
//  SpeechPracticeCompleteView.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 8/1/24.
//

import SwiftUI


struct SpeechPracticeCompleteView: View {
    @State private var isAnimating: Bool = false
    @State private var isListeingSpeechViewPresented: Bool = false
    
    let standardTime: Int
    let elapsedTime: Int
    
    var speakingStructure: SpeakingStructure
    
    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()
            
            Circle()
                .fill(.wh)
                .blur(radius: 20)
                .frame(width: 560, height: 560)
            
            Image("SpeakingPractice-confetti")
                .resizable()
                .scaledToFit()
                .frame(width: 415)
                .offset(y: -50)
                .scaleEffect(isAnimating ? 1 : 0.3)
                .onAppear {
                    withAnimation(.bouncy(duration: 0.5), {
                        isAnimating = true
                    })
                }
            
            VStack {
                Spacer()
                
                Text("질문에 답하기를 완료했어요!")
                    .customFont(.title3_bold2)
                    .padding(.bottom, 20)
                    .padding(.top, 110)
                VStack {
                    Button {
                        self.isListeingSpeechViewPresented = true
                    } label: {
                        ZStack {
                            Capsule()
                                .frame(width: 145, height: 50)
                            HStack {
                                Text("내 답변 듣기")
                                    .customFont(.body3_bold)
                                Image(systemName: "play.fill")
                            }
                            .foregroundStyle(.white)
                        }
                    }
                    .foregroundStyle(Color.main.gradient.shadow(.inner(color: .white.opacity(0.7), radius: 3)))
                    HStack(spacing: 24) {
                        Text("권장시간 : \(timeToString())")
                            .customFont(.body3_bold)
                            .foregroundStyle(.gray3)
                        Text("소요시간 : \(calcElapsedTime())")
                            .customFont(.body3_bold)
                            .foregroundStyle(.gray3)
                    }
                    .padding(.bottom, 70)
                    .padding(.top, 10)
                }
                .padding(.top, 30)

                Spacer()

                Button {
                    Router.shared.popToWritingCompleteView()
                } label: {
                    HStack {
                        Text("다시 말해보기")
                            .font(.custom("Pretendard-Medium", size: 18))
                        Image(systemName: "arrow.counterclockwise")
                    }
                }
                .foregroundStyle(.main)
                .padding(.bottom)
                
                Button {
                    Router.shared.popToRootView()
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
        .sheet(isPresented: $isListeingSpeechViewPresented) {
            ListeningSpeechView(vm: .init(time: (standardTime - elapsedTime)/10), isPresented: $isListeingSpeechViewPresented)
        }
    }
    
    private func timeToString() -> String {
        let realTime = standardTime / 10
        let min = realTime / 60
        let sec = realTime % 60
        return "\(min)분 \(sec)초"
    }
    
    private func calcElapsedTime() -> String {
        let realTime = standardTime / 10
        let realCurrentTime = elapsedTime / 10
        
        if realCurrentTime == 0 {
            return timeToString()
        } else {
            let elapsedTime = -realCurrentTime + realTime
            let min = elapsedTime / 60
            let sec = elapsedTime % 60
            
            return "\(min)분 \(sec)초"
        }
    }
}

#Preview {
    SpeechPracticeCompleteView(standardTime: 1000, elapsedTime: 100, speakingStructure: .grow)
}
