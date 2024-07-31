//
//  SpeechSpeedStatus.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/31/24.
//

import Foundation

/**
 토픽 선택 후 말하기 연습 시에 말하기 속도 선택을 알려주는 열거형
 
 기준 430CPM(Characters Per Minute)
 */

enum SpeechSpeedStatus: Int {
    case slow = 0
    case standard, fast
    
    public var speechText: String {
        switch self {
        case .slow:
            "천천히 말하기"
        case .standard:
            "권장 시간"
        case .fast:
            "속도감 있게 말하기"
        }
    }
}
