//
//  TopicListView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 8/1/24.
//

import SwiftUI

struct TopicListView: View {
    var topic: String

    //임시
    let topicResources: [TopicResource] = [
        .init(type: .casual, content: "가장 기억에 남는 여행지는 어딘가요?", lsStructure: SpeakingStructure.prep.rawValue),
        .init(type: .casual, content: "이성과 감성 중 무엇이 더 중요할까요?", lsStructure: SpeakingStructure.prep.rawValue),
        .init(type: .casual, content: "하루 중 가장 좋아하는 시간대는 언제인가요?", lsStructure: SpeakingStructure.star.rawValue),
        .init(type: .casual, content: "스트레스를 받을 때 어떤 방법으로 해소하시나요?", lsStructure: SpeakingStructure.star.rawValue),
        .init(type: .casual, content: "기억에 남는 꿈이 있나요? 그 꿈이 어떤 내용이었나요?", lsStructure: SpeakingStructure.aida.rawValue),
        .init(type: .casual, content: "어릴 적 꿈꿨던 직업은 무엇인가요? 그 꿈이 어떻게 변해왔나요?", lsStructure: SpeakingStructure.grow.rawValue),
        .init(type: .casual, content: "최근에 읽은 책이나 본 영화 중에서 가장 인상 깊었던 것은 무엇인가요?", lsStructure: SpeakingStructure.aida.rawValue),
        .init(type: .casual, content: "가장 좋아하는 계절은 무엇인가요? 그 계절을 좋아하는 이유는 무엇인가요?", lsStructure: SpeakingStructure.prep.rawValue),
        .init(type: .casual, content: "일상적인 습관을 개선하거나 바꿔본 적이 있나요?", lsStructure: SpeakingStructure.psb.rawValue),
        .init(type: .formal, content: "팀워크에서 가장 중요한 요소는 무엇이라고 생각하시나요?", lsStructure: SpeakingStructure.prep.rawValue),
        .init(type: .formal, content: "당신의 삶을 한 문장으로 설명하면 무엇인가요?", lsStructure: SpeakingStructure.aida.rawValue),
        .init(type: .formal, content: "10년 후 미래의 자신에게 어떤 편지를 쓰고 싶나요?", lsStructure: SpeakingStructure.grow.rawValue),
        .init(type: .formal, content: "지금까지 삶에서 가장 중요한 결정은 무엇인가요?", lsStructure: SpeakingStructure.star.rawValue),
        .init(type: .formal, content: "자신의 이상적인 직장 동료는 어떤 사람인가요?", lsStructure: SpeakingStructure.prep.rawValue),
        .init(type: .formal, content: "어떤 문제를 해결하기 위해 팀원들과 협력한 경험이 있나요? ", lsStructure: SpeakingStructure.psb.rawValue),
        .init(type: .formal, content: "당신이 존경하는 인물은 누구이며, 그 이유는 무엇인가요?", lsStructure: SpeakingStructure.aida.rawValue),
        .init(type: .formal, content: "본인의 가장 큰 약점은 무엇이라고 생각하시나요?", lsStructure: SpeakingStructure.prep.rawValue),
        .init(type: .formal, content: "문제가 발생했을 때, 새로운 접근 방식을 시도한 적이 있나요?", lsStructure: SpeakingStructure.psb.rawValue),
        .init(type: .formal, content: "팀워크에서 가장 중요한 요소는 무엇일까요?", lsStructure: SpeakingStructure.prep.rawValue),
        .init(type: .formal, content: "당신의 삶을 한 문장으로 설명하면 무엇인가요?", lsStructure: SpeakingStructure.prep.rawValue)
    ]

    var body: some View {
        VStack {
            HStack {
                Text(topic)
                    .customFont(.title4_bold)
                Spacer()
            }
            Spacer()
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(topicResources) { topicResource in
                        TopicBubbleView(topicContent: topicResource.content, lsName: topicResource.lsStructure, isWideType: true)
                            .padding(.horizontal)
                            .padding(.vertical, 16)
                            .onTapGesture {
                                Router.shared.setTopic(title: topicResource.content)
                                Router.shared.setSelectedStructure(selection: .init(rawValue: topicResource.lsStructure)!)
                                Router.shared.setTopicIntroductionTitle(title: topic)
                                
                                Router.shared.push(screen: .ContentWritingStartWithTopic)
                            }
                    }
                }
            }
        }
        .padding()
        .scrollIndicators(.hidden)
        .background(Color.gray6)
        .toolbarRole(.editor)
        .ignoresSafeArea(edges:.bottom)
    }
}

#Preview {
    NavigationStack {
        TopicListView(topic: "test")
    }
}
