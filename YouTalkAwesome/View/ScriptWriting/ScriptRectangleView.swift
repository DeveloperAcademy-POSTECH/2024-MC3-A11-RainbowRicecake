//
//  ScriptRectangleView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/31/24.
//

import SwiftUI

struct ScriptRectangleView: View {
    let ratio: CGFloat = 180 / 224
    
    var isThisForAdding: Bool
    
    let record: LogicalSpeakingRecord?
    @State var leftDays: Int = 0
    @State var isEventBefore: Bool = true
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.wh)
            .aspectRatio(180/224, contentMode: .fit)
            .background(Color.gray1
                                  .opacity(0.06)
                                  .shadow(color:.gray1, radius: 4, x: 0, y: 4)
                                  .blur(radius: 8, opaque: false)
                  )
            .overlay(alignment: .top) {
                Image(.clip)
                    .offset(y: -25)
            }
            .overlay {
                if isThisForAdding {
                    VStack {
                        Text("새로운 대본 추가하기")
                            .font(.system(size: 18)) //별도 customfont 지정 없음
                            .foregroundStyle(.gray4)
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundColor(.gray4)
                    }
                } else {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("D \(isEventBefore ? "-" : "+") \(abs(leftDays))")
                            .customFont(.title4_light)
                            .foregroundStyle(.gray3)
                        Text(record?.topic ?? "nil")
                            .customFont(.title3_bold)
                        Spacer()
                        HStack {
                            Spacer()
                            Text(record!.isDone ? "작성완료" : "작성 중···")
                                .customFont(.caption1_bold)
                                .foregroundStyle(.gray3)
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 16)
                    .padding(.top, 40)
                    .padding(.bottom, 14)
                    
                }
            }
            .onAppear {
                guard let record = record else { return }
                leftDays = record.designatedTimestamp?.calcDDays() ?? 0
                
                if leftDays < 0 {
                    isEventBefore = false
                }
            }
    }
}

#Preview {
    let record:LogicalSpeakingRecord = .init(topic: "aaa", speakingStructure: .aida, content: [], duration: 13, isDone: false, designatedTimestamp: Date(timeIntervalSinceNow: -1000000), isFreeTopic : false)
    
    ScriptRectangleView(isThisForAdding: false, record: record)
}
