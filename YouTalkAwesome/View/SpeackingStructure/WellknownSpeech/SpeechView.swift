//
//  SpeechView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/31/24.
//

import SwiftUI

struct SpeechView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    let caseSpeech: CaseSpeech
    
    var body: some View {
        ScrollView {
            VStack() {
                SpeechTitleView(caseSpeech: caseSpeech)
                    .padding(.top, 0) // 필요에 따라 여백 추가
                VStack(spacing: 24){
                    SubCardView(speakingStructure: caseSpeech.speakingStructure, contentType: .effect(caseSpeech.effect))
                    SubCardView(speakingStructure: caseSpeech.speakingStructure, contentType: .summary(caseSpeech.summary))
                }
                .padding(.top, 16)
                .padding(.trailing, 2)
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<caseSpeech.speakingStructure.components.count, id: \.self) { index in
                        SpeechFlowComponentView(speech: caseSpeech, index: index)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 36)
            }
            .padding(.bottom, 100)
            
            // 말하기구조 학습하기로 넘어가는 버튼
            Button {
                coordinator.push(.Quiz(structure: caseSpeech.speakingStructure, isRepeat: false))
            } label: {
                Text("\(caseSpeech.speakingStructure.rawValue) 학습하기")
                    .customFont(.body1_bold)
                    .foregroundStyle(Color.main)
            }
            .padding(.bottom, 10)
            
            // 대본쓰기로 넘어가는 버튼
            Button {
                coordinator.push(.ContentWritingStartWithoutTopic(isWithTopic: false, selectedStructure: caseSpeech.speakingStructure))
            } label: {
                RoundedRectangle(cornerRadius: 18)
                    .foregroundStyle(Color.main)
                    .frame(width: 353, height: 54)
                    .overlay(
                        Text("\(caseSpeech.speakingStructure.rawValue) 기반 대본 쓰기")
                            .customFont(.body1_bold)
                            .foregroundStyle(Color.wh)
                    )
            }
            .padding(.bottom, 120)
        }
        .ignoresSafeArea()
        .scrollIndicators(.hidden)
        .toolbarRole(.editor)
    }
}

struct SpeechTitleView: View {
    var caseSpeech: CaseSpeech
    
    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 8) {
                Spacer()
                
                Text("\(caseSpeech.headline)")
                    .customFont(.title2_bold)
                    .foregroundStyle(.bk)
                Text("\(caseSpeech.subline)")
                    .customFont(.title2_bold)
                    .foregroundStyle(.bk)
                HStack(spacing: 0) {
                    Text(caseSpeech.speakingStructure.rawValue)
                        .customFont(.point3) // 원하는 스타일 적용
                        .foregroundColor(.main) // 원하는 색상
                    Text(" 를 활용해보세요!")
                        .customFont(.title2_bold)
                        .foregroundStyle(.bk)
                    Spacer()
                }
            }
            .padding([.top], 16)
            .padding([.leading, .bottom], 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 393, height: 229)
    }
}

struct SubCardView: View {
    var speakingStructure: SpeakingStructure
    enum ContentType: Equatable {
        case effect(String) // 효과 텍스트
        case summary(String) // 요약 텍스트
    }
    var contentType: ContentType // 어떤 콘텐츠를 렌더링할지 결정
    var labelImageName: String {
        switch contentType {
        case .effect:
            return "checkmark.circle.fill"
        case .summary:
            return "square.and.pencil"
        }
    }
    
    // 상단 제목
    var topContent: String {
        switch contentType {
        case .effect:
            return "\(speakingStructure.rawValue)의 효과"
        case .summary:
            return "요약"
        }
    }
    
    // 본문 콘텐츠
    var bodyContent: String {
        switch contentType {
        case .effect(let text), .summary(let text):
            return text
        }
    }
    
    // 뷰 내용
    var body: some View {
        VStack(alignment: .leading) {
            // 상단 Label
            Label(topContent, systemImage: labelImageName)
                .customFont(.body3_bold)
                .foregroundStyle(Color.main)
                .padding(.bottom, 12)
            
            // 본문 Text
            Text(bodyContent)
                .customFont(.body3_light)
                .foregroundStyle(.gray2)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 10)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.main, lineWidth: 4)
                .fill(Color.bg)
                .frame(width: 353)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.main)
                        .offset(x: 4, y: 6)
                }
        }
        .frame(width: 353)
    }
}

#Preview {
    NavigationStack {
        SpeechView(caseSpeech: .onePunch)
    }
}
