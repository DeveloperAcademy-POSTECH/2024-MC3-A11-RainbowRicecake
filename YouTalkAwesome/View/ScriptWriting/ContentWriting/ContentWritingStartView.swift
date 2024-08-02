//
//  ContentWritingStartView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 8/1/24.
//

import SwiftUI

struct ContentWritingStartView: View {
    var isTopic: Bool = false
    
    @State var contentTitle: String? = nil
    @State var presentationDate: String?
    @State var timeLimit: Int?
    @State var selectedSpeakingStructure: SpeakingStructure?
    
    @State var canGoNext: Bool = true
    
    var body: some View {
        VStack(spacing:20) {
            HStack {
                Text("어떤 대본을 작성하시나요?")
                    .customFont(.title2_bold)
                Spacer()
            }
            .padding(.horizontal)
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("제목")
                        .customFont(.body1_bold)
                }
                TextField("대본의 제목을 작성해주세요.", text: Binding(
                    get: { contentTitle ?? "" },
                    set: { contentTitle = $0 }
                ))
                .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal)
            
            if isTopic == false {
                VStack(alignment: .leading) {
                    HStack {
                        Text("예정 날짜")
                            .customFont(.body1_bold)
                    }
                    //TODO: 여기 DatePicker 구현 예정
                    TextField("예정된 날짜 없음", text: Binding(
                        get: { presentationDate ?? "" },
                        set: { presentationDate = $0 }
                    ))
                    .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal)

                VStack(alignment: .leading) {
                    HStack {
                        Text("제한 날짜")
                            .customFont(.body1_bold)
                    }
                    //TODO: 여기 시간 고르는 기능 구현 예정
                    TextField("시간 제한 없음", text: Binding(
                        get: { contentTitle ?? "" },
                        set: { contentTitle = $0 }
                    ))
                    .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("참고할 논리구조")
                        .customFont(.body1_bold)
                }
                .padding(.horizontal)

                ScrollView(.horizontal) {
                    HStack {
                        ForEach (SpeakingStructure.allCases, id: \.self) { speakingStructure in
                            LSCardView(speakingStructure: speakingStructure)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            // 새로운 대본
            NavigationLink(destination: TestPointView()) {
                RoundedRectangle(cornerRadius: 18)
                    .foregroundStyle(canGoNext ? Color.main : Color.gray5)
                    .frame(width: 353, height: 54)
                    .overlay(
                        Text("새로운 대본 만들기")
                            .customFont(.body1_bold)
                            .foregroundStyle(canGoNext ? Color.wh : Color.gray2)
                    )
            }
            .disabled(!canGoNext)
        }
        .background(Color.gray6)
        .toolbarRole(.editor)
    }
}

#Preview {
    NavigationStack {
        ContentWritingStartView(isTopic: false)
    }
}
