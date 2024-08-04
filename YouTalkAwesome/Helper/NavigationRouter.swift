//
//  NavigationRouter.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 8/3/24.
//

import Foundation
import SwiftUI


enum ViewList: Hashable {
    // 말하기 구조 뷰
    case StructureFlow
    
    case Quiz
    case QuizDone
    
    case Speech
    
    // 대본 작성 뷰
    case TopicList
    
    case ContentWritingStartWithTopic
    case ContentWritingStartWithoutTopic
    
    case ContentWritingWithoutTopic
    case ContentWritingWithTopic
    
    case WritingCompleteWithoutTopic
    case WritingCompleteWithTopic
    
    case ScriptPracticeWithTopic
    
    case SpeechPracticeComplete
    

}

final class Router: ObservableObject {
    @Published public var route: [ViewList] = []
    
    static let shared = Router()
    
    private var isTopicSelected: Bool = false
    private var topic: String?
    private var selectedStructure: SpeakingStructure?
    private var selectedDate : Date?
    private var selectedTime : Int?
    private var estimatedTime: Int?
    private var structureSections : [StructureSection] = []
    private var selectedSpeech: WellKnownSpeech?
    
    private var audioManager: AudioManager?
    private var scriptPracticeViewModel: ScriptPracticeViewModel?
    
    private var selectedTopicList: String?
    
    private init() {}
}

// MARK: - 네비게이션 관련 메소드
extension Router {
    public func push(screen: ViewList) {
        route.append(screen)
    }
    
    @ViewBuilder
    public func pushView(screen: ViewList) -> some View {
        switch screen {
            // 대본 작성 뷰
        case .TopicList:
            TopicListView(topic: selectedTopicList ?? "test")
            
        case .ContentWritingStartWithTopic:
            ContentWritingStartView(isTopic: true, contentTitle: self.topic ?? "nil", selectedSpeakingStructure: self.selectedStructure)
        case .ContentWritingStartWithoutTopic:
            ContentWritingStartView(isTopic: isTopicSelected, selectedSpeakingStructure: self.selectedStructure)
            
        case .ContentWritingWithoutTopic, .ContentWritingWithTopic:
            ContentWritingView(topic: self.topic ?? "nil", selectedStructure: self.selectedStructure ?? .aida, designatedDate: self.selectedDate,  expectedLeadTime: selectedTime, isFreeTopic: !isTopicSelected)
                .toolbar(.hidden, for: .tabBar)
        case .WritingCompleteWithoutTopic:
            WritingCompleteView(title: self.topic ?? "nil", isTopicSelected: false, selectedDate: self.selectedDate, selectedTime: self.selectedTime, structureSections: structureSections)
                .toolbar(.hidden, for: .tabBar)
        case .WritingCompleteWithTopic:
            WritingCompleteView(title: self.topic ?? "nil", isTopicSelected: true, structureSections: structureSections)
            
        case .ScriptPracticeWithTopic:
            ScriptPracticeView(isPresented: .constant(false), isTopicSelected: true, vm: self.scriptPracticeViewModel!, structureSections: self.structureSections)
            
        case .SpeechPracticeComplete:
            SpeechPracticeCompleteView(standardTime: self.scriptPracticeViewModel?.time ?? 0, elapsedTime: self.scriptPracticeViewModel?.currentTime ?? 0, speakingStructure: self.selectedStructure ?? .aida)
                .navigationBarBackButtonHidden()
            
            // 말하기 구조 뷰
        case .StructureFlow:
            StructureFlowView(speakingStructure: self.selectedStructure ?? .aida)
            
        case .Quiz:
            QuizView(lsStructure: self.selectedStructure ?? .aida)
        case .QuizDone:
            QuizDoneView(speakingStructure: self.selectedStructure ?? .aida)
            
        case .Speech:
            SpeechView(speech: self.selectedSpeech!)
        }
    }
    
    public func popToRootView() {
        self.route = []
    }
    
    public func popToWritingCompleteView() {
        var flag = true
        
        while flag {
            if let path = route.last {
                if path == .WritingCompleteWithTopic {
                    flag = false
                    break
                }
                _ = route.popLast()!
            }
        }
    }
}


// MARK: - 프로퍼티 관리 메소드
extension Router {
    public func setIsTopicSelected(_ isTopicSelected: Bool) {
        self.isTopicSelected = isTopicSelected
    }
    
    public func setTopic(title: String) {
        self.topic = title
    }
    
    public func setSelectedStructure(selection: SpeakingStructure) {
        self.selectedStructure = selection
    }
    
    public func setStructureSections(_ structureSections: [StructureSection]) {
        self.structureSections = structureSections
    }
    
    public func setEstimatedTime(time: Int) {
        self.estimatedTime = time
    }
    
    public func setDateAndTime(date: Date, time: Int) {
        self.selectedDate = date
        self.selectedTime = time
    }
    
    public func setTopicList(name: String) {
        self.selectedTopicList = name
    }
    
    public func setSpeech(speech: WellKnownSpeech) {
        self.selectedSpeech = speech
    }
    
    public func makeVM(time: Int) {
        self.scriptPracticeViewModel = .init(time: time)
    }
}
