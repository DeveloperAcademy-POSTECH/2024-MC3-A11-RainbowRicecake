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
    
    public var viewModel: ScriptPracticeViewModel {
        self.scriptPracticeViewModel!
    }
    
    public var audio: AudioManager {
        self.audioManager!
    }
    
    public var structure: [StructureSection] {
        self.structureSections
    }
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
            ContentWritingStartView(isTopic: false, selectedSpeakingStructure: self.selectedStructure)
            
        case .ContentWritingWithoutTopic, .ContentWritingWithTopic:
            ContentWritingView(topic: self.topic ?? "nil", selectedStructure: self.selectedStructure ?? .aida, designatedDate: self.selectedDate,  expectedLeadTime: selectedTime, isFreeTopic: !isTopicSelected)
                .toolbar(.hidden, for: .tabBar)
                .toolbarRole(.editor)
            
        case .WritingCompleteWithoutTopic:
            WritingCompleteView(title: self.topic ?? "nil", isTopicSelected: false, selectedDate: self.selectedDate, selectedTime: self.selectedTime, structureSections: structureSections, structure: .aida)
                .toolbarRole(.editor)
                .toolbar(.hidden, for: .tabBar)
        case .WritingCompleteWithTopic:
            WritingCompleteView(title: self.topic ?? "nil", isTopicSelected: true, structureSections: structureSections, structure: .aida)
                .toolbarRole(.editor)
                .toolbar(.hidden, for: .tabBar)
            
        case .ScriptPracticeWithTopic:
            ScriptPracticeView(isPresented: .constant(false), isTopicSelected: true, time: 1, structureSections: self.structureSections, selectedStructure: .aida)
                .toolbarRole(.editor)
            
        case .SpeechPracticeComplete:
            SpeechPracticeCompleteView(standardTime: self.scriptPracticeViewModel?.time ?? 0, elapsedTime: self.scriptPracticeViewModel?.currentTime ?? 0, speakingStructure: self.selectedStructure ?? .aida, structureSections: [])
                .navigationBarBackButtonHidden()
                .toolbar(.hidden, for: .tabBar)
            
            // 말하기 구조 뷰
        case .StructureFlow:
            StructureFlowView(speakingStructure: self.selectedStructure ?? .aida)
                .toolbarRole(.editor)
            
        case .Quiz:
            QuizView(lsStructure: self.selectedStructure ?? .aida)
                .toolbarRole(.editor)
        case .QuizDone:
            QuizDoneView(isRepeat: false, speakingStructure: self.selectedStructure ?? .aida)
                .toolbarRole(.editor)
        case .Speech:
            SpeechView(speech: self.selectedSpeech!)
                .toolbarRole(.editor)
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
    
    public func makeAudioManager() {
        self.audioManager = AudioManager()
    }
    
    public func resetProperty() {
        self.isTopicSelected = false
        self.topic = nil
        self.selectedStructure = nil
        self.selectedDate = nil
        self.selectedTime = nil
        self.estimatedTime = nil
        self.structureSections = []
        self.selectedSpeech = nil
        self.audioManager = nil
        self.scriptPracticeViewModel = nil
        self.selectedTopicList = nil
    }
}


final class AppCoordinator: AppCoordinatorProtocol {
    @Published public var speakingStructurePath: NavigationPath = .init()
    @Published public var scriptWritingPath: NavigationPath = .init()
    @Published public var archivePath: NavigationPath = .init()
    
    var currentScreen: currentScreen = .speakingStructure
    
    var sheet: Sheet?
    var fullScreenCover: FullScreenCover?
    
    func push(_ screen: Screen) {
        switch self.currentScreen {
        case .speakingStructure:
            speakingStructurePath.append(screen)
            print(speakingStructurePath.count)
        case .scriptWriting:
            scriptWritingPath.append(screen)
        case .archive:
            archivePath.append(screen)
        }
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        switch self.currentScreen {
        case .speakingStructure:
            if speakingStructurePath.count > 0 {
                speakingStructurePath.removeLast()
            }
        case .scriptWriting:
            if scriptWritingPath.count > 0 {
                scriptWritingPath.removeLast()
            }
        case .archive:
            if archivePath.count > 0 {
                archivePath.removeLast()
            }
        }
    }
    
    func popToRoot() {
        switch self.currentScreen {
        case .speakingStructure:
            speakingStructurePath.removeLast(speakingStructurePath.count)
        case .scriptWriting:
            scriptWritingPath.removeLast(scriptWritingPath.count)
        case .archive:
            archivePath.removeLast(archivePath.count)
        }
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    
    @ViewBuilder
    @MainActor
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .StructureFlow(let structure):
            StructureFlowView(speakingStructure: structure)
                .toolbarRole(.editor)
        case .Quiz(let structure, let isRepeat):
            QuizView(lsStructure: structure, isRepeat: isRepeat)
                .toolbarRole(.editor)
        case .QuizDone(let structure, let isRepeat):
            QuizDoneView(isRepeat: isRepeat, speakingStructure: structure)
                .toolbarRole(.editor)
        case .Speech(let speech):
            SpeechView(speech: speech)
                .toolbarRole(.editor)
        case .TopicList(let topic):
            TopicListView(topic: topic)
        case .ContentWritingStartWithTopic(let isWithTopic, let title, let structure):
            ContentWritingStartView(isTopic: isWithTopic, contentTitle: title, selectedSpeakingStructure: structure)
        case .ContentWritingStartWithoutTopic(let isWithTopic, let structure):
            ContentWritingStartView(isTopic: isWithTopic, contentTitle: "", selectedSpeakingStructure: structure)
        case .ContentWritingWithoutTopic(let title, let structure, let date, let time, let isTopic):
            ContentWritingView(topic: title, selectedStructure: structure, designatedDate: date, expectedLeadTime: time, isFreeTopic: isTopic)
                .toolbar(.hidden, for: .tabBar)
                .toolbarRole(.editor)
        case .ContentWritingWithTopic(let title, let structure, let isTopic):
            ContentWritingView(topic: title, selectedStructure: structure, designatedDate: nil, expectedLeadTime: nil, isFreeTopic: isTopic)
                .toolbar(.hidden, for: .tabBar)
                .toolbarRole(.editor)
        case .WritingCompleteWithoutTopic(let title, let date, let time, let sections, let structure):
            WritingCompleteView(title: title, isTopicSelected: true, selectedDate: date, selectedTime: time, structureSections: sections, structure: structure)
                .toolbarRole(.editor)
                .toolbar(.hidden, for: .tabBar)
        case .WritingCompleteWithTopic(let title, let sections, let structure):
            WritingCompleteView(title: title, isTopicSelected: false, structureSections: sections, structure: structure)
                .toolbarRole(.editor)
                .toolbar(.hidden, for: .tabBar)
        case .SpeechPracticeComplete(let standardTime, let elapsedTime, let structure, let sections):
            SpeechPracticeCompleteView(standardTime: standardTime, elapsedTime: elapsedTime, speakingStructure: structure, structureSections: sections)
                .navigationBarBackButtonHidden()
                .toolbar(.hidden, for: .tabBar)
        case .ScriptPracticeWithTopic(let time, let section, let structure):
            ScriptPracticeView(isPresented: .constant(false), isTopicSelected: true, time: time, structureSections: section, selectedStructure: structure)
        }
    }
    
    enum currentScreen {
        case speakingStructure
        case scriptWriting
        case archive
    }
}



protocol AppCoordinatorProtocol: ObservableObject {
    var speakingStructurePath: NavigationPath { get set }
    var scriptWritingPath: NavigationPath { get set }
    var archivePath: NavigationPath { get set }
    
    var sheet: Sheet? { get set }
    var fullScreenCover: FullScreenCover? { get set }
    
    func push(_ screen: Screen)
    func presentSheet(_ sheet: Sheet)
    func presentFullScreenCover(_ fullScreenCover: FullScreenCover)
    
    func pop()
    func popToRoot()
    
    func dismissSheet()
    func dismissFullScreenCover()
}


enum Screen: Identifiable, Hashable {
    case StructureFlow(structure: SpeakingStructure)
    
    case Quiz(structure: SpeakingStructure, isRepeat: Bool)
    case QuizDone(structure: SpeakingStructure, isRepeat: Bool)
    
    case Speech(speech: WellKnownSpeech)
    
    // 대본 작성 뷰
    case TopicList(topic: String)
    
    case ContentWritingStartWithTopic(isWithTopic: Bool, title: String, selectedStructure: SpeakingStructure?)
    case ContentWritingStartWithoutTopic(isWithTopic: Bool, selectedStructure: SpeakingStructure?)
    
    case ContentWritingWithoutTopic(title: String, structure: SpeakingStructure, date: Date?, time: Int?, isTopic: Bool)
    case ContentWritingWithTopic(title: String, structure: SpeakingStructure, isTopic: Bool)
    
    case WritingCompleteWithoutTopic(title: String, date: Date?, time: Int?, structure: [StructureSection], ss: SpeakingStructure)
    case WritingCompleteWithTopic(title: String, structure: [StructureSection], ss: SpeakingStructure)
    
    case ScriptPracticeWithTopic(time: Int, section: [StructureSection], structure: SpeakingStructure)
    
    case SpeechPracticeComplete(standardTime: Int, elapsedTime: Int, structure: SpeakingStructure, section: [StructureSection])
    
    var id: Self { self }
}

enum Sheet: Identifiable, Hashable {
    case none
    
    var id: Self { self }
}

enum FullScreenCover: Identifiable, Hashable {

    case none(test: () -> Void)
    
    var id: Self { self }
}




// MARK: - 열거형 프로토콜 충족
extension Screen {
    func hash(into hasher: inout Hasher) {
        switch self {
        default:
            hasher.combine("hashable")
        }
    }
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        switch (lhs, rhs) {
        default:
            return true
        }
    }
}


extension FullScreenCover {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .none:
            hasher.combine("none")
        }
    }
    
    static func == (lhs: FullScreenCover, rhs: FullScreenCover) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        }
    }
}
