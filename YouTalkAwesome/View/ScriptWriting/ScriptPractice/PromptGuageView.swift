//
//  PromptGuageView.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/30/24.
//

import SwiftUI

struct PromptGuageView: View {
    let time: Int
    
    @Binding var elapsedTime: CGFloat
    
    var body: some View {
        HStack(spacing: 11) {
            
            ZStack {
                Capsule()
                    .frame(height: 20)
                    .foregroundStyle(.gray)
                
                HStack {
                    Capsule()
                        .frame(height: 20)
                    
                    Spacer(minLength: self.elapsedTime)
                    
                }
            }
            
            Text("\(time)")
            
        }
    }
}
