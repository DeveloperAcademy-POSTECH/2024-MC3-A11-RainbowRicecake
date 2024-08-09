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
        .init(type: .formal, content: "팀워크에서 가장 중요한 요소는 무엇이라고 생각하시나요?", lsStructure: SpeakingStructure.prep.rawValue),
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
                    ForEach(topicResources) { topic in
                        TopicBubbleView(topicContent: topic.content, lsName: topic.lsStructure, isWideType: true)
                            .padding(.horizontal)
                            .padding(.vertical, 16)
                            .onTapGesture {
                                Router.shared.setTopic(title: topic.content)
                                Router.shared.setSelectedStructure(selection: .init(rawValue: topic.lsStructure)!)
                                
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
