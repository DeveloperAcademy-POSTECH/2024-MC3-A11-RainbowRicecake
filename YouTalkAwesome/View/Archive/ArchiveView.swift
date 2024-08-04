//
//  ArchiveView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/29/24.
//

import SwiftUI
import UIKit
import SwiftData

struct ArchiveView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Query(sort: \LogicalSpeakingRecord.id) var records: [LogicalSpeakingRecord]
    
    @StateObject var practicePointsViewModel = PracticePointsDataHandler.shared
    
    @StateObject private var viewModel: ArchiveViewModel = .init()
    
    @State private var selectedView: SelectedView = .writtenScript
    @State private var scrollObservableViewHeight: CGFloat = 0
    
    @StateObject var router = Router.shared
    
    let width: CGFloat = (UIScreen.main.bounds.width - 42) / 3
    
    var body: some View {
        NavigationStack(path: $router.route) {
            ScrollView {
                LazyVStack(pinnedViews: .sectionHeaders) {
                    historyView
                    
                    Section {
                        switch selectedView {
                        case .answeredQuestion:
                            answeredQuestionView
                        case .writtenScript:
                            writtenScript
                        }
                    } header: {
                        VStack(spacing: 0) {
                            scrollObservableView
                            
                            ArchiveSegmentView(selectedView: $selectedView)
                                .background(.white)
                        }
                    }
                }
                .onPreferenceChange(ScrollOffsetKey.self) { value in
                    if value <= safeAreaInsets.top - 10 {
                        withAnimation {
                            self.scrollObservableViewHeight = safeAreaInsets.top
                        }
                    } else {
                        self.scrollObservableViewHeight = 0
                    }
                    viewModel.setOffset(value)
                }
                .navigationDestination(for: ViewList.self) { screen in
                    router.pushView(screen: screen)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        
    }
    
    private var historyView: some View {
        ZStack {
            Color.bg
            
            VStack(spacing: 2) {
                HStack(spacing: 0) {
                    VStack (spacing: 8) {
                        Image(systemName: "flowchart.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.gray5)
                        
                        Text("말하기 구조 학습")
                            .customFont(.caption1_bold)
                            .foregroundStyle(.gray3)
                
                        Text("\(practicePointsViewModel.getCount())")
                            .customFont(.title3_bold)
                            .foregroundStyle(.main)
                    }
                    .frame(width: width)
                    
                    Capsule()
                        .frame(width: 1)
                        .foregroundStyle(.gray5)

                    VStack (spacing: 8) {
                        Image(systemName: "questionmark.bubble.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.gray5)
                        
                        Text("답변한 질문")
                            .customFont(.caption1_bold)
                            .foregroundStyle(.gray3)
                        Text("\(records.filter{$0.isFreeTopic == false}.count)")
                            .customFont(.title3_bold)
                            .foregroundStyle(.main)
                    }
                    .frame(width: width)

                    Capsule()
                        .frame(width: 1)
                        .foregroundStyle(.gray5)

                    VStack (spacing: 8) {
                        Image(systemName: "applescript.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.gray5)
                        
                        Text("작성한 대본")
                            .customFont(.caption1_bold)
                            .foregroundStyle(.gray3)
                        Text("\(records.filter{$0.isFreeTopic == true}.count)")
                            .customFont(.title3_bold)
                            .foregroundStyle(.main)
                    }
                    .frame(width: width)
                }
                
                NavigationLink(destination: LearningStatusView().toolbarRole(.editor)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 72)
                            .foregroundStyle(.white)
                            .background {
                                Color.gray1
                                    .opacity(0.04)
                                    .shadow(color: .gray1, radius: 4, x: 0, y: 4)
                                    .blur(radius: 8, opaque: false)
                            }
                        
                        HStack {
                            Text("나의 말하기 구조 학습 현황")
                                .customFont(.title4_bold)
                                .foregroundStyle(.gray3)
                            
                            Spacer()
                            Image(systemName: "arrow.right.circle.fill")
                                .resizable()
                                .foregroundStyle(.main)
                                .frame(width: 32, height: 32)
                            
                        }
                        .padding(.leading, 33)
                        .padding(.trailing, 24)
                    }
                }
                .padding(.vertical, 32)
            }
            .padding(.horizontal, 20)
            .padding(.top, 80)
            
        }
    }

    private var answeredQuestionView: some View {
        
        let filtered  = records.filter {$0.isFreeTopic == false}
        
        return ForEach(filtered) { record in
            TopicBubbleView(topicContent: record.topic, lsName: record.speakingStructure.rawValue, isWideType: true)
                .onTapGesture {
                    router.setTopic(title: record.topic)
                    router.setStructureSections(record.content)
                    router.push(screen: .WritingCompleteWithTopic)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
        }
    }
    
    private var writtenScript: some View {
        
        let filtered  = records.filter {$0.isFreeTopic == true}
        
        return LazyVGrid(columns: [.init(spacing: 24), .init(spacing: 0)], spacing: 32) {
            ForEach(filtered) { record in
                ScriptRectangleView(isThisForAdding: false, record: record)
                    .onTapGesture {
                        router.setTopic(title: record.topic)
                        router.setDateAndTime(date: record.designatedTimestamp!, time: record.duration)
                        router.setStructureSections(record.content)
                        router.push(screen: .WritingCompleteWithoutTopic)
                    }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 34)
        
    }
    
    private var scrollObservableView: some View {
        GeometryReader { proxy in
            let offsetY = proxy.frame(in: .global).origin.y
            Color.white
                .preference(
                    key: ScrollOffsetKey.self,
                    value: offsetY
                )
                .onAppear { // 나타날때 뷰의 최초위치를 저장하는 로직
                    viewModel.setOriginOffset(offsetY)
                }
        }
        .frame(height: self.scrollObservableViewHeight)
    }
    

}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container : ModelContainer = {
        let schema = Schema([LogicalSpeakingRecord.self])
        
        do {
            return try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    let testRecord : LogicalSpeakingRecord = .init(topic: "아카데미에서 제일 잘생긴 사람은", speakingStructure: .prep, content: [], duration: 90, isDone: true, isFreeTopic: false)
    
    let testRecord1 : LogicalSpeakingRecord = .init(topic: "아카데미에서 제일 방구 소리가 큰 사람은", speakingStructure: .psb, content: [], duration: 90, isDone: true, isFreeTopic: false)
    
    let testRecord2 : LogicalSpeakingRecord = .init(topic: "커리어의 지향점은?", speakingStructure: .prep, content: [], duration: 90, isDone: true, isFreeTopic: true)
    
    let testRecord3 : LogicalSpeakingRecord = .init(topic: "아카데미에서 제일 가치있었던 경험은?", speakingStructure: .prep, content: [], duration: 90, isDone: true, isFreeTopic: true)
    
    let testRecord4 : LogicalSpeakingRecord = .init(topic: "추후 당신의 커리어에서 AI를 어떻게 사용할 것인가요?", speakingStructure: .prep, content: [], duration: 90, isDone: true, isFreeTopic: true)
    
    
    container.mainContext.insert(testRecord)
    container.mainContext.insert(testRecord1)
    container.mainContext.insert(testRecord2)
    container.mainContext.insert(testRecord3)
    container.mainContext.insert(testRecord4)
    
    return ArchiveView()
        .modelContainer(container)
}

