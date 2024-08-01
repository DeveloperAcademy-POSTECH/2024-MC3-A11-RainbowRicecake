//
//  LearningStatusView.swift
//  YouTalkAwesome
//
//  Created by 최하늘 on 8/1/24.
//

import SwiftUI


struct LearningStatusView: View {
    @StateObject var practicePointsViewModel = PracticePointsViewModel()
    var speakingStructure: SpeakingStructure
    
    let width: CGFloat = 345
    let height: CGFloat = 152
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 32) {
                Text("나의 말하기 구조 학습 현황")
                    .customFont(.title4_bold)
                    .padding(.top, 16)
                
                VStack(spacing: 32) {
                    ForEach (SpeakingStructure.allCases, id: \.self) { speakingStructure in
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black, lineWidth: 3)
                            .fill(.white)
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
                                    ZStack(alignment: .leading){
                                        Capsule()
                                            .frame(width: 305, height: 20)
                                            .foregroundColor(.blue)
                                        Capsule()
                                            .frame(width: 30.5 * CGFloat(practicePointsViewModel.getPoint(key: speakingStructure.rawValue)), height: 20)
                                            .foregroundColor(.green)
                                    }
                                    .overlay(
                                        HStack(spacing: 4) {
                                            Text("\(practicePointsViewModel.getPoint(key: speakingStructure.rawValue))")
                                            Text("/")
                                            Text("10")
                                        }
                                            .customFont(.caption1_bold)
                                            .foregroundColor(.white)
                                    )
                                }
                                .padding()
                            }
                    }
                }
            }
            .padding()
        }
        .padding(.horizontal, 20)
        .background(Color(hex: "F1F3F6"))
    }
}

#Preview {
    LearningStatusView(speakingStructure: .prep)
}
