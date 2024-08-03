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
                HStack(alignment: .bottom) {
                    Text(speakingStructure.rawValue)
                        .customFont(.point1)
                    Text("+1")
                        .font(.system(size: 24, weight: .medium))
                        .offset(y: -5)
                }
                .padding(.top, 150)
                
                Text("말하기 구조 학습을 완료했어요!")
                    .customFont(.body1_bold)
                
                
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
                
                Spacer()
                
                Button {
                    self.isListeingSpeechViewPresented = true
                } label: {
                    ZStack {
                        Capsule()
                            .frame(width: 145, height: 50)
                        
                        HStack {
                            Text("내 답변 듣기")
                            Image(systemName: "play.fill")
                        }
                        .foregroundStyle(.white)
                    }
                }
                .foregroundStyle(LinearGradient(colors: [ .init(hex: "71FBD2"), .init(hex: "7BC8AD")], startPoint: .center, endPoint: .bottomTrailing))
                .padding(.top, 27)
                
                HStack(spacing: 24) {
                    Text("권장시간 : \(timeToString())")
                        .font(.custom("Pretendard-Medium", size: 16))
                        .foregroundStyle(.gray3)
                    
                    Text("소요시간 : \(calcElapsedTime())")
                        .font(.custom("Pretendard-Medium", size: 16))
                        .foregroundStyle(.gray3)
                }
                .padding(.bottom, 70)
                .padding(.top, 50)

                
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
