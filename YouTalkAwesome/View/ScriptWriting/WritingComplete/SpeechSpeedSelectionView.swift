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
                .foregroundStyle(.wh)
            
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
                        if !(speechSpeedStatus == .slow) {
                            Image(systemName: "chevron.left")
                        }
                    }
                    .foregroundStyle(.gray3)
                    
                    Spacer()
                    
                    Text(speechSpeedStatus.speechText)
                        .customFont(.body1_bold)
                        .foregroundStyle(.gray3)
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
                        if !(self.speechSpeedStatus == .fast) {
                            Image(systemName: "chevron.right")
                        }
                    }
                    .foregroundStyle(.gray3)
                    
                    Spacer()
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 46)
                        .padding(.horizontal, 14)
                        .foregroundStyle(.bg)
                    
                    HStack(spacing: 20) {
                        Text(speedMinText())
                            .customFont(.title3_bold)
                            .foregroundStyle(.main)
                        
                        Text(":")
                            .customFont(.title3_bold)
                            .foregroundStyle(.main)
                        
                        Text(speedSecText())
                            .customFont(.title3_bold)
                            .foregroundStyle(.main)
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
        switch self.speechSpeedStatus {
        case .slow:
            let result = self.speechSpeed[0] % 60
            return result < 10 ? "0\(result)" : "\(result)"
        case .standard:
            let result = self.speechSpeed[1] % 60
            return  result < 10 ? "0\(result)" : "\(result)"
        case .fast:
            let result = self.speechSpeed[2] % 60
            return  result < 10 ? "0\(result)" : "\(result)"
        }
    }
}


#Preview {
    SpeechSpeedSelectionView(speechSpeedStatus: .constant(.standard), speechSpeed: [0, 1, 2])
}
