//
//  LSWideCardView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/29/24.
//

import SwiftUI

struct LSWideCardView: View {
    var logicalStructure: LogicalStructure
    
    let width: CGFloat = 354
    let height: CGFloat = 118
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(.black, lineWidth: 3)
            .fill(.white)
            .frame(width: width, height: height)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(logicalStructure.color)
                    .offset(x: 10, y: 10)
            }
            .overlay {
                HStack{
                    VStack (alignment: .leading) {
                        LSNameView(name: logicalStructure)
                        LSDescriptionView(shortDescription: logicalStructure.description )
                    }
                    Spacer()
                    Image("\(logicalStructure.rawValue)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                .padding()
            }
    }
}

#Preview {
    LSWideCardView(logicalStructure: .prep)
}
