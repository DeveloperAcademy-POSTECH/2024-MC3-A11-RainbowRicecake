//
//  ScriptWritingView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/29/24.
//

import SwiftUI

// TODO: 추구 Type 파일에 병합 필요.
struct ScriptRecord: Identifiable {
    var id: UUID = UUID()
    var leftDay : String
    var scriptTitle : String
    var isDone : Bool
}

enum TopicType: CaseIterable {
    case casual
    case formal
}

struct TopicResource: Identifiable {
    var id: UUID = UUID()
    var type : TopicType
    var content : String
    var lsStructure : String
}

struct ScriptWritingView: View {
    let scriptRecords: [ScriptRecord] = [
        .init(leftDay: "5", scriptTitle: "애플 리뷰 준비", isDone: false)
    ]
    
    let topicResources:[TopicResource] = [
        .init(type: .casual, content: "가장 기억에 남는 여행지는 어딘가요?", lsStructure: SpeakingStructure.prep.rawValue),
        .init(type: .casual, content: "이성과 감성 중 무엇이 더 중요할까요?", lsStructure: SpeakingStructure.prep.rawValue),
        .init(type: .formal, content: "팀워크에서 가장 중요한 요소는 무엇이라고 생각하시나요?", lsStructure: SpeakingStructure.prep.rawValue),
        .init(type: .formal, content: "당신의 삶을 한 문장으로 설명하면 무엇인가요?", lsStructure: SpeakingStructure.prep.rawValue)
    ]
    
    let preparedSituation = [
        "나에게 모두 이목집중 👀","한 방 터뜨리기 👊🏻","날카로운 상황 분석 📈","내 잠재력 어필하기 💫", "깔끔 요약정리 ✍🏻", "내 말에 설득당할 걸? 😎", "멋진 성장 스토리 🍀","현재 문제점 진단하기 🦔", "나의 경험 어필하기 🤓", "해결책 제시하기 💡", "문제해결 능력 어필⚡️", "생생하게 상황 묘사 🌼"
    ]
    
    @ViewBuilder
    func makeSituationCard(_ situation: String) -> some View {
        Text(situation)
            .font(.system(size: 18, weight: .regular)) //별도 customfont 지정 없음
            .frame(height: 16)
            .background {
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.grey6)
                        .frame(width: geometry.size.width + 15, height: 44)
                        .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                }
            }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                InstructionTextView(instructionKeyword : ["말하기 구조","대본"], verbalPart: ["로", "을 작성해보세요!"])
                    .padding()
                    .padding(.top, 45)
                
                if scriptRecords != nil{ 
                    // TODO: 스크립트 > SWIFTDATA , 토픽/상황설명 등의 데이터들은 > JSON 혹은 STRUCT에 담아서 보관하는 것으로 추후 수정 필요.
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(scriptRecords) {
                                ScriptRectangleView(isThisForAdding: false, leftDay: $0.leftDay, scriptTitle: $0.scriptTitle , isDone: $0.isDone )
                            }
                        }
                        .padding(25)
                    }
                }  else {
                    HStack {
                        Spacer()
                        ScriptRectangleView(isThisForAdding: true)
                        Spacer()
                    }
                    .padding(25)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.bg)
            

            
            ForEach(TopicType.allCases, id: \.self) { type in
                let topicsPerType = topicResources.filter { $0.type == type}
                
                VStack {
                    HStack {
                        Text( type == TopicType.casual ? "생각하는 힘 기르기 💡" : "면접 대비!")
                            .customFont(.title4_bold)
                        Spacer()
                        Image(systemName: "chevron.right")
                        
                    }
                    .padding([.top,.horizontal])
                    
                    ScrollView(.horizontal) {
                        HStack (spacing: 16) {
                            ForEach(topicsPerType) {
                                TopicBubbleView(topicContent: $0.content, lsName: $0.lsStructure, isWideType: false)
                            }
                        }
                        .padding(.top, 5)
                        .padding([.bottom,.horizontal])
                    }
                }
            }
            
            VStack {
                HStack {
                    Text("어떤 상황을 준비하시나요?")
                        .customFont(.title4_bold)
                    Spacer()
                    Image(systemName: "chevron.right")
                    
                }
                .padding([.top, .horizontal])
                
                ScrollView (.horizontal) {
                    ForEach(0..<3) { rowIndex in
                        HStack {
                            makeSituationCard(preparedSituation[rowIndex*4]).padding([.vertical, .trailing])
                            makeSituationCard(preparedSituation[rowIndex*4 + 1]).padding([.vertical, .trailing])
                            makeSituationCard(preparedSituation[rowIndex*4 + 2]).padding([.vertical, .trailing])
                            makeSituationCard(preparedSituation[rowIndex*4 + 3]).padding([.vertical, .trailing])
                        }
                        .padding(.leading)
                    }
                }
            }
        }.ignoresSafeArea(.container, edges: [.top, .horizontal])
    }
}


#Preview {
    ScriptWritingView()
}
