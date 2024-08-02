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
                        .font(.system(size: 40, weight: .bold))
                    Text("+1")
                        .font(.system(size: 24, weight: .medium))
                        .offset(y: -5)
                }
                .padding(.top, 150)
                
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
                .padding(.top, 27)
                
                HStack {
                    Text("권장시간 : \(timeToString())")
                    
                    Text("소요시간 : \(calcElapsedTime())")
                }
                .padding(.bottom, 70)
                .padding(.top, 50)

                
                Button {
                    
                } label: {
                    HStack {
                        Text("다시 말해보기")
                        Image(systemName: "arrow.counterclockwise")
                    }
                }
                
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.main)
                        .frame(width: 353, height: 54)
                        .overlay {
                            Text("홈으로")
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
