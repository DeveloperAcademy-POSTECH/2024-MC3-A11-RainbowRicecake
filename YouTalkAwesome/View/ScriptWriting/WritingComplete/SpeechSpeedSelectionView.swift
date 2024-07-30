//
//  SpeechSpeedSelectionView.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/30/24.
//

import SwiftUI

struct SpeechSpeedSelectionView: View {
    @State private var speedStatus: SpeechSpeedStatus = .standard
    
    let speechSpeed: [Int]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .frame(height: 120)
                .foregroundStyle(.indigo)
            
            VStack(spacing: 11) {
                HStack {
                    Spacer()
                    
                    Button {
                        switch speedStatus {
                        case .slow:
                            break
                        case .standard:
                            self.speedStatus = .slow
                        case .fast:
                            self.speedStatus = .standard
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    
                    Spacer()
                    
                    Text(speedStatus.speechText)
                        .frame(width: 150)
                    
                    Spacer()

                    Button {
                        switch speedStatus {
                        case .slow:
                            self.speedStatus = .standard
                        case .standard:
                            self.speedStatus = .fast
                        case .fast:
                            break
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                    
                    Spacer()
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 46)
                        .padding(.horizontal, 14)
                        .foregroundStyle(.gray)
                    
                    HStack(spacing: 20) {
                        Text(speedMinText())
                        
                        Text(":")
                        
                        Text(speedSecText())
                    }
                }
            }
        }
    }
    
    private func speedMinText() -> String {
        switch self.speedStatus {
        case .slow:
            let result = self.speechSpeed[0] / 60
            return "\(result)"
        case .standard:
            let result = self.speechSpeed[1] / 60
            return "\(result)"
        case .fast:
            let result = self.speechSpeed[2] / 60
            return "\(result)"
        }
    }
    
    private func speedSecText() -> String {
        print(speechSpeed)
        switch self.speedStatus {
        case .slow:
            let result = self.speechSpeed[0] % 60
            return "\(result)"
        case .standard:
            let result = self.speechSpeed[1] % 60
            return "\(result)"
        case .fast:
            let result = self.speechSpeed[2] % 60
            return "\(result)"
        }
    }
    
    
    private enum SpeechSpeedStatus {
        case slow, standard, fast
        
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
}
