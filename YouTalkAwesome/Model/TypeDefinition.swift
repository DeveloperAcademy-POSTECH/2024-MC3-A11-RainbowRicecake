//
//  type.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/28/24.
//
import Foundation
import SwiftUI

enum LogicalStructure : String, CaseIterable {
    case star = "STAR"
    case prep = "PREP"
    case aida = "AIDA"
    case psb = "PSB"
    case grow = "GROW"
    
    var components: [String] {
        switch self {
            case .star : return ["Situation","Task","Action","Result"]
            case .prep : return ["Point","Reason","Example","Point"]
            case .aida : return ["Attention","Interest","Desire", "Action"]
            case .psb : return ["Problem","Solution","Benefit"]
            case .grow : return ["Goal","Reality","Options","Will"]
        }
    }
    
    var description: String {
        switch self {
            case .star : return "과거의 경험을 설명하고 싶을 때"
            case .prep : return "논리적인 설명이 필요할 때"
            case .aida : return "청중의 이목을 집중시켜야할 때"
            case .psb : return "문제에 대한 해결책을 제시할 때"
            case .grow : return "목표와 잠재력을 어필하고 싶을 때"
        }
    }
    
    var color : Color {
        switch self {
            case .star : return .blue
            case .prep : return .purple
            case .aida : return .pink
            case .psb : return .yellow
            case .grow : return .mint
        }
    }
}

extension LogicalStructure : Codable {}
