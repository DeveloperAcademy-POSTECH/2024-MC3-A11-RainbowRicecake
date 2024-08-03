//
//  AnswerCompleteView.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/29/24.
//

import SwiftUI

struct WritingCompleteView: View {
    @State private var isPresented: Bool = false
    @State private var speedStatus: SpeechSpeedStatus = .standard
//    @State private var audioManager: AudioManager = .init()
    
    let title: String
    let isTopicSelected: Bool
    
    var selectedDate: Date?
    var selectedTime: Int?
    var structureSections: [StructureSection]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text( self.isTopicSelected ? "Q. \(title)" : title)
                        .font(.custom("Pretendard-SemiBold", size: 20))
                    
                    if !isTopicSelected, selectedDate != nil, selectedTime != nil {
                        HStack(spacing: 20) {
                            Label(selectedDate!.getYMDDate(), systemImage: "calendar")
                                .customFont(.body2_light)
                                .foregroundStyle(.gray3)
                            
                            Label(durationToMinute(), systemImage: "clock")
                                .customFont(.body2_light)
                                .foregroundStyle(.gray3)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.horizontal, 22)
            .padding(.bottom, 16)
            .background(.bg)
            

            
            ScrollView(.vertical) {
                // TODO: 나중에 수정 필요
//                ForEach(structureSectionSample, id: \.self) { section in
//                    StructureSectionView(topContent: section.topContent, bottomContent: section.bodyContent, isScript: section.isScript)
//                }
                ForEach(self.structureSections, id: \.self) { section in
                    StructureSectionView(topContent: section.topContent, bottomContent: section.bodyContent, isScript: section.isScript)
                }
                
                Spacer(minLength: self.isTopicSelected ? 200 : 70)
            }
            .scrollIndicators(.hidden)
        }
        .overlay(alignment: .bottom) {
            if self.isTopicSelected {
                ZStack(alignment: .bottom) {
                    // TODO: 색 수정
                    LinearGradient(colors: [.bk.opacity(0.7), .clear], startPoint: .bottom, endPoint: .top)
                        .ignoresSafeArea(edges: .bottom)
                        .allowsHitTesting(false)
                    
                    VStack {
                        SpeechSpeedSelectionView(speechSpeedStatus: $speedStatus, speechSpeed: calcStringCount())
                        
                        speechStartButtonWithTopic
                        
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 300)
            } else {
                ZStack(alignment: .bottom) {
                    // TODO: 색 수정
                    LinearGradient(colors: [.bk.opacity(0.7), .clear], startPoint: .bottom, endPoint: .top)
                        .ignoresSafeArea(edges: .bottom)
                        .allowsHitTesting(false)
                    
                    speechStartButton
                        .padding(20)
                    
                }
                .frame(height: 300)
            }
        }
        .toolbar {
            if !isTopicSelected {
                ToolbarItem(placement: .topBarTrailing) {
                    // TODO: 하이파이에 따라 수정 예정
                    Button("마치기") {
                        Router.shared.popToRootView()
                    }
                    .tint(.main)
                }
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            ScriptPracticeView(isPresented: $isPresented, isTopicSelected: self.isTopicSelected, vm: .init(time: selectedTime ?? 0), structureSections: self.structureSections)
                .ignoresSafeArea(edges: .bottom)
        }
        .task {
            if isTopicSelected {
                if await AudioManager.requestPermission() {
                    print("success!")
                } else {
                    print("fail!")
                }
            }
        }
    }
    
    var speechStartButton: some View {
        Button {
            isPresented = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .frame(height: 54)
                    .foregroundStyle(.main)
                
                Text( self.isTopicSelected ? "말하기 연습 시작" : "프롬프트 재생")
                    .customFont(.body1_bold)
                    .foregroundStyle(.wh)
            }
        }
    }
    
    var speechStartButtonWithTopic: some View {
        Button {
            Router.shared.makeVM(time: calcStringCount()[self.speedStatus.rawValue])
            Router.shared.push(screen: .ScriptPracticeWithTopic)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .frame(height: 54)
                    .foregroundStyle(.main)
                
                Text( self.isTopicSelected ? "말하기 연습 시작" : "프롬프트 재생")
                    .customFont(.body1_bold)
                    .foregroundStyle(.wh)
            }
        }
    }
    
    private func durationToMinute() -> String {
        let minute = self.selectedTime! / 60
        let second = self.selectedTime! % 60
        
        let result = (minute == 0 ? "\(second)초" : "\(minute)분 \(second)초")
        
        return result
    }
    
    private func calcStringCount() -> [Int] {
        var charCount = 0
        _ = structureSections.map {
            charCount += $0.bodyContent.count
        }
        
        let slowCPM = 387 / 60.0
        let standardCPM = 430 / 60.0
        let fastCPM = 473 / 60.0
        
        let slowDuration = Double(charCount) / slowCPM
        let standardDuration = Double(charCount) / standardCPM
        let fastDuration = Double(charCount) / fastCPM
        
        return [Int(slowDuration), Int(standardDuration), Int(fastDuration)]
    }
}


#Preview {
    NavigationStack {
        WritingCompleteView(title: "AI를 활용한 UX 디자인", isTopicSelected: false, selectedDate: Date(), selectedTime: 3, structureSections: structureSectionSample)
    }
}


let structureSectionSample: [StructureSection] = [
    StructureSection(topContent: "Point (요점)", bodyContent: "AI는 UX디자이너의 작업을 혁신적으로 변화시키고, 더 효율적으로 창의적인 작업 환경을 제공합니다.", isScript: true),
    StructureSection(topContent: "Reason (이유)", bodyContent: "티몬과 위메프가 기업회생절차를 신청한 건, 수천억원대에 이르는 셀러(판매자) 미정산 대금 등 회사의 빚을 온전히 감당할 수 없기 때문으로 풀이된다. 티몬과 위메프를 지배하는 구영배 큐텐 대표가 보유 지분 매각 등을 통한 사재 출연을 약속했으나, 이마저도 채무 상환엔 턱없이 부족하다는 의미다.", isScript: true),
    StructureSection(topContent: "🫲", bodyContent: "\"혁신적인\"에서 제스처", isScript: false),
    StructureSection(topContent: "Example (예시)", bodyContent: "통상 법원은 기업의 신청일로부터 1개월 안에 회생절차 개시 여부를 결정한다. 티몬과 위메프의 경우 자율 구조조정 지원 프로그램(ARS프로그램)을 신청한 까닭에 채권자들의 견해와 법원 판단에 따라서 최장 3개월간 회사와 채무자 간 자율 협의 절차를 거칠 수도 있다. 여기서 빚 상환 여부 등이 합의되면 회생절차를 취소하고, 협약 체결이 무산되면 회생절차를 진행하게 된다.", isScript: true),
    StructureSection(topContent: "🙂", bodyContent: "미소짓기", isScript: false),
    StructureSection(topContent: "Point (요점)", bodyContent: "두 회사의 회생 절차 신청과 셀러·피지사들의 손실 복구 장기화 등으로 뒤늦게 지원책과 제도 보완에 나선 정부 책임론도 커질 것으로 보인다. 금융 당국은 이날 “회사의 판매 대금 미정산으로 이미 피해가 현실화된 만큼 회생 신청으로 인해 상황이 크게 달라지지 않을 것”이라며 “기존에 마련한 정부 지원책을 신속하게 집행하고 필요하면 추가적인 지원 방안을 모색할 것”이라고 했다.", isScript: true),
    StructureSection(topContent: "⭐️", bodyContent: "마지막 문장 강조", isScript: false)
]
