//
//  ExampleCardView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/29/24.
//

import SwiftUI

struct ExampleCardView: View {
    var logicalStructure : LogicalStructure
    var title: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 205, height: 128)
            .overlay {
                VStack (alignment: .leading) {
                    HStack {
                        Spacer()
                        LSStickerView(lsName: logicalStructure.rawValue)
                    }
                    Spacer()
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 140)
                }.padding()
            }
            .padding()
    }
}

#Preview {
    ExampleCardView(logicalStructure: .psb, title: "원인이 어려운 장애 극복하기")
}
