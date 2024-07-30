//
//  LSCardView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/29/24.
//

import SwiftUI

//LS: Logical Speaking
struct LSCardView: View {
    var logicalStructure: LogicalStructure
    
    let width: CGFloat = 260
    let height: CGFloat = 318
    
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
                VStack  {
                    HStack {
                        VStack (alignment: .leading) {
                            LSNameView(name: logicalStructure)
                            LSDescriptionView(shortDescription: logicalStructure.description )
                        }
                        Spacer()
                    }
                    .padding()
                    Spacer()
                    HStack {
                        Spacer()
                        Image("\(logicalStructure.rawValue)")
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
    var name : LogicalStructure
    
    var body: some View {
        Text("\(name.rawValue)")
            .font(.system(size: 40))
            .fontWeight(.black)
        
    }
}

struct LSDescriptionView : View {
    var shortDescription : String
    
    var body: some View {
        Text("\(shortDescription)")
            .foregroundStyle(.gray)
            .font(.system(size: 16))
            
            
    }
}

#Preview {
    LSCardView(logicalStructure: .prep)
}
