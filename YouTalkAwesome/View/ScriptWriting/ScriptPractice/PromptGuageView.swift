//
//  PromptGuageView.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/30/24.
//

import SwiftUI

struct PromptGuageView: View {
    var currentTime: Int
    let entireTime: Int
    
    var body: some View {
        HStack(spacing: 11) {
            ZStack {
                GeometryReader { proxy in
                    let elapsedTime = Double(entireTime - currentTime) / Double(entireTime)
                    let spacerLength: CGFloat = proxy.size.width * CGFloat(elapsedTime)
                    
                    Capsule()
                        .frame(height: 20)
                        .foregroundStyle(Color.init(hex: "EFEFEF"))
                    
                    HStack {
                        Capsule()
                            .frame(height: 20)
                            .foregroundStyle(Color.init(hex: "51D7A7"))
                        
                        Spacer(minLength: spacerLength)
                        
                    }
                }
                .frame(height: 20)
            }
            // TODO: 폰트 확인 필요
            Text(self.currentTime < 0 ? "+\(currentMinToString()):\(currentSecToString())" : "\(currentMinToString()):\(currentSecToString())")
                .customFont(.title4_bold)
                .monospaced()
                .animation(nil)
        }
        .animation(.linear, value: currentTime)
    }
    
    private func currentMinToString() -> String {
        var result = self.currentTime / 600
        if result < 0 {
            result = -result
        }
        return ( result < 10 ) ? "0\(result)" : "\(result)"
    }
    
    private func currentSecToString() -> String {
        var result = self.currentTime % 600 / 10
        if result < 0 {
            result = -result
        }
        return ( result < 10 ) ? "0\(result)" : "\(result)"
    }
}

#Preview {
    PromptGuageView(currentTime: 80, entireTime: 100)
}
