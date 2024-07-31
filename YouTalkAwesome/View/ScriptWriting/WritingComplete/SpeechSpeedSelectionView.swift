//
//  SpeechSpeedSelectionView.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/30/24.
//

import SwiftUI

struct SpeechSpeedSelectionView: View {
    @Binding var speechSpeedStatus: SpeechSpeedStatus
    
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
                        switch speechSpeedStatus {
                        case .slow:
                            break
                        case .standard:
                            self.speechSpeedStatus = .slow
                        case .fast:
                            self.speechSpeedStatus = .standard
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    
                    Spacer()
                    
                    Text(speechSpeedStatus.speechText)
                        .frame(width: 150)
                    
                    Spacer()

                    Button {
                        switch speechSpeedStatus {
                        case .slow:
                            self.speechSpeedStatus = .standard
                        case .standard:
                            self.speechSpeedStatus = .fast
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
        switch self.speechSpeedStatus {
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
        switch self.speechSpeedStatus {
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
}


