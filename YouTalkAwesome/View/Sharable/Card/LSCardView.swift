//
//  LSCardView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/29/24.
//

import SwiftUI

//LS: Logical Speaking
struct LSCardView: View {
    var speakingStructure: SpeakingStructure
    
    let width: CGFloat = 260
    let height: CGFloat = 318
    
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
                VStack  {
                    HStack {
                        VStack (alignment: .leading) {
                            LSNameView(name: speakingStructure)
                            LSDescriptionView(shortDescription: speakingStructure.description )
                        }
                        Spacer()
                    }
                    .padding()
                    Spacer()
                    HStack {
                        Spacer()
                        Image("\(speakingStructure.rawValue)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 165, height: 165)
                    }
                }
            }
            .padding() 
    }
}

struct LSNameView : View {
    var name : SpeakingStructure
    
    var body: some View {
        Text("\(name.rawValue)")
            .customFont(.point1)
            .foregroundStyle(.bk)
    }
}

struct LSDescriptionView : View {
    var shortDescription : String
    
    var body: some View {
        Text("\(shortDescription)")
            .customFont(.body2_light)
            .foregroundStyle(.gray1)
    }
}

#Preview {
    LSCardView(speakingStructure: .prep)
}
