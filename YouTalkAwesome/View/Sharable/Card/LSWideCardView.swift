//
//  LSWideCardView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/29/24.
//

import SwiftUI

struct LSWideCardView: View {
    var speakingStructure: SpeakingStructure
    
    let width: CGFloat = 354
    let height: CGFloat = 118
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(.bk, lineWidth: 3)
            .fill(.wh)
            .frame(width: width, height: height)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(speakingStructure.color)
                    .offset(x: 10, y: 10)
            }
            .overlay {
                HStack{
                    VStack (alignment: .leading) {
                        LSNameView(name: speakingStructure)
                        LSDescriptionView(shortDescription: speakingStructure.description )
                    }
                    Spacer()
                    Image("\(speakingStructure.rawValue)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                .padding()
            }
    }
}

#Preview {
    LSWideCardView(speakingStructure: .prep)
}
