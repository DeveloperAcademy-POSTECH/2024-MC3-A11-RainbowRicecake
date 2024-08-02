//
//  LSWideCardView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/29/24.
//

import SwiftUI

struct LSWideCardView: View {
    @StateObject var practicePointsViewModel = PracticePointsViewModel()
    var speakingStructure: SpeakingStructure
    
    let width: CGFloat = 345
    let height: CGFloat
    
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
                VStack{
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
                    
                    if height == 152
                    {
                        ZStack(alignment: .leading){
                            Capsule()
                                .frame(width: 305, height: 20)
                                .foregroundColor(.gray6)
                            Capsule()
                                .frame(width: 30.5 * CGFloat(practicePointsViewModel.getPoint(key: speakingStructure.rawValue)), height: 20)
                                .foregroundColor(speakingStructure.color)
                        }
                        .overlay(
                            HStack(spacing: 4) {
                                // 게이지가 절반이 넘어갈 때 색깔의 분기점이 생기기 때문에 경우 나눠서 색 지정
                                Text("\(practicePointsViewModel.getPoint(key: speakingStructure.rawValue))")
                                    .foregroundColor(practicePointsViewModel.getPoint(key: speakingStructure.rawValue) < 5 ? .gray3 : .white)
                                Text("/")
                                    .foregroundColor(practicePointsViewModel.getPoint(key: speakingStructure.rawValue) < 5 ? .gray3 : .white)
                                Text("10")
                                    .foregroundColor(practicePointsViewModel.getPoint(key: speakingStructure.rawValue) < 6 ? .gray3 : .white)
                            }
                                .customFont(.caption1_bold)
                        )
                    }
                    
                }
                .padding()
            }
    }
}

#Preview {
    LSWideCardView(speakingStructure: .prep, height: 152)
}
