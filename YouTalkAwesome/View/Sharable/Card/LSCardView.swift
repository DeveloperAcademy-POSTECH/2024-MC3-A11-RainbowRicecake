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
    let height: CGFloat = 338
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(.bk, lineWidth: 6)
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
                        VStack (alignment: .leading, spacing: 6) {
                            LSNameView(name: speakingStructure)
                            LSDescriptionView(shortDescription: speakingStructure.description )
                        }
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    Spacer()
                    HStack {
                        Spacer()
                        Image("\(speakingStructure.rawValue)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 140)
                            .padding(.trailing, 20)
                            .padding(.bottom, 16)
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
            .customFont(.body2_light2)
            .foregroundStyle(.gray1)
    }
}

#Preview {
    LSCardView(speakingStructure: .prep)
}
