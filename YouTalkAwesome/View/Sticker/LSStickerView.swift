//
//  LSSticker.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/29/24.
//

import SwiftUI

struct LSStickerView: View {
    var lsName : String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.main)
            .frame(width: 58, height: 24)
            .overlay {
                Text(lsName)
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .semibold))
            }
    }
}

#Preview {
    LSStickerView(lsName: SpeakingStructure.prep.rawValue)
}
