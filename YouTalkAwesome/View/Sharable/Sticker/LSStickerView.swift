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
                    .customFont(.point5)
                    .foregroundStyle(.wh)
            }
    }
}

#Preview {
    LSStickerView(lsName: SpeakingStructure.prep.rawValue)
}
