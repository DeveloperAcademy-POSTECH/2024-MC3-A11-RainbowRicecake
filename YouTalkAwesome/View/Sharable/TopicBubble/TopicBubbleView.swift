//
//  TopicBubbleView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/31/24.
//

import SwiftUI

struct TopicBubbleView: View {
    
    let topicContent: String
    let lsName: String
    
    let isWideType: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader {
                Text(topicContent)
                    .customFont(.body1_light)
                    .frame(width: $0.size.width - 10, alignment: .leading)
                    .lineSpacing(8)
                    .padding([.top, .leading], 10)
            }
            Spacer()
            
            HStack {
                Spacer()
                LSStickerView(lsName: lsName)
                    .padding([.bottom, .trailing], 10)
            }
        }
        .padding(5)
        .frame(width: isWideType ? 353 : 205 ,height: 110)
        .background {
            TopicBubbleShape()
                .stroke(.bk, lineWidth: 1)
                .fill(.wh)
            
        }
    }
}

#Preview {
    VStack {
        TopicBubbleView(topicContent: "가장 기억에 남는 여행지는 어딘가요?", lsName: "STAR", isWideType: false)
        
        TopicBubbleView(topicContent: "팀워크에서 중요한 요소는 무엇이라고 생각하시나요?", lsName: "STAR", isWideType: false)
    }
    
}
