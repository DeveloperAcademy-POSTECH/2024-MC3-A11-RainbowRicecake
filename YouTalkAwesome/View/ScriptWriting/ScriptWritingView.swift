//
//  ScriptWritingView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/29/24.
//

import SwiftUI
import SwiftData

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
        .init(type: .casual, content: "하루 중 가장 좋아하는 시간대는 언제인가요?", lsStructure: SpeakingStructure.star.rawValue),
        .init(type: .casual, content: "스트레스를 받을 때 어떤 방법으로 해소하시나요?", lsStructure: SpeakingStructure.star.rawValue),
        .init(type: .casual, content: "기억에 남는 꿈이 있나요? 그 꿈이 어떤 내용이었나요?", lsStructure: SpeakingStructure.aida.rawValue),
        .init(type: .casual, content: "어릴 적 꿈꿨던 직업은 무엇인가요? 그 꿈이 어떻게 변해왔나요?", lsStructure: SpeakingStructure.grow.rawValue),
        .init(type: .casual, content: "최근에 읽은 책이나 본 영화 중에서 가장 인상 깊었던 것은 무엇인가요?", lsStructure: SpeakingStructure.aida.rawValue),
        .init(type: .casual, content: "가장 좋아하는 계절은 무엇인가요?", lsStructure: SpeakingStructure.prep.rawValue),
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
    
    let preparedSituation = [
        "나에게 모두 이목집중 👀","한 방 터뜨리기 👊🏻","날카로운 상황 분석 📈","내 잠재력 어필하기 💫", "깔끔 요약정리 ✍🏻", "내 말에 설득당할 걸? 😎", "멋진 성장 스토리 🍀","현재 문제점 진단하기 🦔", "나의 경험 어필하기 🤓", "해결책 제시하기 💡", "문제해결 능력 어필⚡️", "생생하게 상황 묘사 🌼"
    ]
    @EnvironmentObject private var coordinator: AppCoordinator
    
    @StateObject var router = Router.shared
    
    @Query(filter: #Predicate<LogicalSpeakingRecord> { $0.isFreeTopic }) var records: [LogicalSpeakingRecord]
    @State private var filteredRecords: [LogicalSpeakingRecord] = []
    
    @ViewBuilder
    func makeSituationCard(_ situation: String) -> some View {
        Text(situation)
            .customFont(.body3_light)
            .frame(height: 16)
            .background {
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray6)
                        .frame(width: geometry.size.width + 15, height: 44)
                        .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                }
            }
            .onTapGesture {
            }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                InstructionTextView(
                    instructionKeyword : [ filteredRecords.isEmpty ? "말하기 구조" : filteredRecords.first!.topic ,filteredRecords.isEmpty ? "대본" : "\(filteredRecords.first!.designatedTimestamp!.calcDDays())"],
                    verbalPart: [filteredRecords.isEmpty ? "로" : "까지", filteredRecords.isEmpty ? "을 작성해보세요!" : "일 남았어요!"]
                )
                .padding()
                .padding(.top, 60)
                
                if !filteredRecords.isEmpty {
                    // TODO: 스크립트 > SWIFTDATA , 토픽/상황설명 등의 데이터들은 > JSON 혹은 STRUCT에 담아서 보관하는 것으로 추후 수정 필요.
                    ScrollView(.horizontal) {
                        HStack {
                            Button {
                                coordinator.push(.ContentWritingStartWithoutTopic(isWithTopic: false, selectedStructure: nil))
                            } label: {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .foregroundColor(.gray4)
                            }
                            .padding(.trailing, 5)
                            
                            
                            ForEach(filteredRecords) { record in
                                ScriptRectangleView(isThisForAdding: false, record: record)
                                    .onTapGesture {
//                                        router.setDateAndTime(date: record.designatedTimestamp!, time: record.duration)
//                                        router.setTopic(title: record.topic)
//                                        router.setIsTopicSelected(false)
//                                        router.setSelectedStructure(selection: record.speakingStructure)
//                                        router.setStructureSections(record.content)
//                                        router.push(screen: .WritingCompleteWithoutTopic)
//                                        coordinator.push(.WritingCompleteWithoutTopic(title: record.designatedTimestamp!, date: record.duration, time: 1, structure: record.content))
                                        coordinator.push(.WritingCompleteWithoutTopic(title: record.topic, date: record.designatedTimestamp!, time: record.duration, structure: record.content))
                                    }
                                    .padding(.leading, 6)
                            }
                        }
                        .padding(30)
                    }
                    .frame(height: 280)
                } else {
                    HStack {
                        Spacer()
                        ScriptRectangleView(isThisForAdding: true, record: nil)
                            .padding(.horizontal, 75)
                            .onTapGesture {
//                                router.setIsTopicSelected(false)
//                                router.push(screen: .ContentWritingStartWithoutTopic)
                                coordinator.push(.ContentWritingStartWithoutTopic(isWithTopic: false, selectedStructure: nil))
                            }
                        
                        Spacer()
                    }
                    .padding(25)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.bg)
            
            ForEach(TopicType.allCases, id: \.self) { type in
                let topicsPerType = topicResources.filter { $0.type == type}
                let topicTitle = (type == TopicType.casual) ? "생각하는 힘 기르기 💡" : "면접 대비! 실전 연습 ✨"
                
                VStack {
                    HStack {
                        Text( type == TopicType.casual ? "생각하는 힘 기르기 💡" : "면접 대비! 실전 연습 ✨")
                            .customFont(.title4_bold)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .onTapGesture {
//                                router.setTopicList(name: type == TopicType.casual ? "생각하는 힘 기르기 💡" : "면접 대비!")
//                                router.push(screen: .TopicList)
                                
                                coordinator.push(.TopicList(topic: topicTitle))
                            }
                        
                    }
                    .padding([.top,.horizontal])
                    
                    ScrollView(.horizontal) {
                        HStack (spacing: 16) {
                            ForEach(topicsPerType) { topic in
                                TopicBubbleView(topicContent: topic.content, lsName: topic.lsStructure, isWideType: false)
                                    .onTapGesture {
//                                        router.setTopic(title: topic.content)
//                                        router.setSelectedStructure(selection: .init(rawValue: topic.lsStructure)!)
//                                        router.setIsTopicSelected(true)
//                                        router.push(screen: .ContentWritingStartWithTopic)
                                        
                                        coordinator.push(.ContentWritingStartWithTopic(isWithTopic: true, introductionTitle: topicTitle, title: topic.content, selectedStructure: .init(rawValue: topic.lsStructure)!))
                                    }
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
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea(.container, edges: [.top, .horizontal])
        .navigationBarBackButtonHidden()
        .onAppear {
            self.filteredRecords = records.filter { $0.designatedTimestamp!.calcDDays() >= Date().calcDDays() }
        }
        .onChange(of: records) {
            self.filteredRecords = records.filter { $0.designatedTimestamp!.calcDDays() >= Date().calcDDays() }
        }
    }
    
    private func evaluateSituation(text: String) -> SpeakingStructure {
        switch text {
        case "깔끔 요약정리 ✍🏻", "내 말에 설득당할 걸? 😎":
            return .prep
        case "나의 경험 어필하기 🤓", "멋진 성장 스토리 🍀":
            return .star
        case "내 잠재력 어필하기 💫", "날카로운 상황 분석 📈":
            return .grow
        case "한 방 터뜨리기 👊🏻", "나에게 모두 이목집중 👀":
            return .aida
        default:
            return .psb
        }
    }
}


#Preview {
    ScriptWritingView()
}


