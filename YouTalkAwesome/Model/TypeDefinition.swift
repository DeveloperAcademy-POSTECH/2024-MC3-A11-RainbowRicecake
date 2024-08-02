//
//  type.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/28/24.
//
import Foundation
import SwiftUI

enum SpeakingStructure: String, CaseIterable {
    case prep = "PREP"
    case star = "STAR"
    case aida = "AIDA"
    case psb = "PSB"
    case grow = "GROW"
    
    var description: String {
        switch self {
        case .prep : return "논리적인 설명이 필요할 때"
        case .star : return "과거의 경험을 설명하고 싶을 때"
        case .aida : return "청중의 이목을 집중시켜야할 때"
        case .psb : return "문제에 대한 해결책을 제시할 때"
        case .grow : return "목표와 잠재력을 어필하고 싶을 때"
        }
    }
    
    var color: Color {
        switch self {
        case .prep : return Color.prep
        case .star : return Color.star
        case .aida : return Color.aida
        case .psb : return Color.psb
        case .grow : return Color.grow
        }
    }
    
    var components: [String] {
        switch self {
        case .prep : return ["Point","Reason","Example","Point"]
        case .star : return ["Situation","Task","Action","Result"]
        case .aida : return ["Attention","Interest","Desire", "Action"]
        case .psb : return ["Problem","Solution","Benefit"]
        case .grow : return ["Goal","Reality","Options","Will"]
        }
    }
    
    var components_kor: [String] {
        switch self {
        case .prep : return ["요점","이유","예시","요점"]
        case .star : return ["상황","임무","행동","결과"]
        case .aida : return ["관심 끌기","흥미 유발하기","욕구 불러일으키기","행동 유도하기"]
        case .psb : return ["문제","해결책","이점"]
        case .grow : return ["목표 설정","현재 상황 분석","가능 대안 고려","진행 방법, 의지 표현"]
        }
    }
    
    var componentDescriptions: [String] {
        switch self {
        case .prep : return [
            "말하고자 하는 요점을 명확하게 제시합니다",
            "그 요점에 대한 이유를 설명합니다",
            "그 이유를 뒷받침하는 구체적인 예시를 제시합니다",
            "다시 한번 요점을 강조합니다"
        ]
        case .star : return [
            "상황을 설명합니다",
            "그 상황에서 수행해야 했던 임무를 설명합니다",
            "그 임무를 수행하기 위해 취한 행동을 설명합니다",
            "그 행동의 결과를 설명합니다"
        ]
        case .aida : return [
            "상대방의 관심을 끕니다",
            "흥미를 유발합니다",
            "욕구를 불러일으킵니다",
            "행동을 유도합니다"
        ]
        case .psb : return [
            "문제를 제기합니다",
            "해결책을 제시합니다",
            "그 이점을 설명합니다"
        ]
        case .grow : return [
            "목표를 설정합니다",
            "현재 상황을 분석합니다",
            "가능한 대안들을 고려합니다",
            "진행 방법과 그 의지를 표현합니다"
        ]
        }
    }
    
    var componentExamples: [String] {
        switch self {
        case .prep : return [
            "초콜릿은 최고의 간식이라고 생각해요.",
            "초콜릿은 기분을 좋게 하고 에너지를 즉각적으로 공급해줍니다.",
            "예를 들어, 저는 스트레스 받을 때마다 초콜릿을 먹습니다. 그러면 기분이 한결 나아지고, 피로도 풀리는 느낌이 들어요. 과학적으로도 초콜릿에 들어있는 카카오 성분이 행복 호르몬인 세로토닌을 분비시킨다고 합니다.",
            "그래서 초콜릿은 맛있을 뿐만 아니라 기분을 좋게 만들어 주는 최고의 간식입니다."
        ]
        case .star : return ["예시문장","예시문장","예시문장","예시문장"]
        case .aida : return ["예시문장","예시문장","예시문장","예시문장"]
        case .psb : return ["예시문장","예시문장","예시문장"]
        case .grow : return ["예시문장","예시문장","예시문장","예시문장"]
        }
    }
    
    var quizSentences: [String] {
        switch self {
        case .prep : return [
            "재택근무는 직원들의 생산성을 높입니다.",
            "출퇴근 시간이 없어져서 직원들이 더 많은 시간을 업무에 집중할 수 있기 때문입니다.",
            "예를 들어, 한 연구에 따르면 재택근무를 도입한 회사들의 직원 생산성이 평균 20% 증가했다고 합니다.",
            "따라서 재택근무는 생산성을 높이는 데 매우 효과적인 방법입니다."
        ]
        case .star : return ["퀴즈문장","퀴즈문장","퀴즈문장","퀴즈문장"]
        case .aida : return ["퀴즈문장","퀴즈문장","퀴즈문장","퀴즈문장"]
        case .psb : return ["퀴즈문장","퀴즈문장","퀴즈문장"]
        case .grow : return ["퀴즈문장","퀴즈문장","퀴즈문장","퀴즈문장"]
        }
    }
    
    var effect: String {
        switch self {
        case .prep : return "prep의 효과"
        case .star : return "복잡한 이야기를 명확하게 전달하고, 청중의 관심을 끌고, 그들의 행동을 유도하는 데 매우 유용한 기법입니다."
        case .aida : return "aida의 효과"
        case .psb : return "psb의 효과"
        case .grow : return "grow의 효과"
        }
    }
}

extension SpeakingStructure : Codable {}
