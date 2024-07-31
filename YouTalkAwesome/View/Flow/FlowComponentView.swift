//
//  FlowView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/30/24.
//

import SwiftUI

//재활용 버전을 위해 일단 만들어 둠, 아직 완성은 아님-> 재활용 쪼금 까다롭고 넘 지저분해지는거 같아서 일단 따로 만들겟음~~
//TODO: TextEditor를 이용한 input 받는 뷰는 따로 만들어야 함
//TODO: 해당 뷰가 나타났을 때 width가 늘어나 세로로만 펼쳐지는게 아닌 가로로도 펼쳐지는 느낌이 조금 남 -> 이거는 애니메이션 효과때문에 어쩔 수 없는듯ㅠ
struct FlowComponentView: View {
    var speakingStructure: SpeakingStructure
    var index: Int
    @Binding var showTextBox: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .fill(speakingStructure.color)
                .frame(width: 9, height: 9)
                .offset(y: 7)
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("\(speakingStructure.components[index]) (\(speakingStructure.components_kor[index]))")
                        .fontWeight(.bold)
                        .foregroundStyle(speakingStructure.color)
                    Text("\(speakingStructure.componentDescriptions[index])")
                        .foregroundStyle(Color(hex:"898A8D"))
                        .font(.system(size: 14))
                        .padding(.bottom, showTextBox ? 0 : 10)
                }
                if showTextBox {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex: "898A8D"), lineWidth: 1)
                        .fill(Color.white)
                        .overlay(
                            Text("\(speakingStructure.componentExamples[index])")
                                .font(.system(size: 14))
                                .fontWeight(.light)
                                .padding()
                                .fixedSize(horizontal: false, vertical: true),
                            alignment: .topLeading
                        )
                        .frame(height: getTextHeight(for: speakingStructure.componentExamples[index], in: UIScreen.main.bounds.width))
                        .padding(.bottom)
                }
            }
        }
        .background(alignment: .leading) {
            if index != speakingStructure.components.count - 1 {
                Rectangle()
                    .foregroundColor(speakingStructure.color)
                    .frame(width: 3/*, height: getTextHeight(for: speakingStructure.componentExamples[index], in: UIScreen.main.bounds.width)*/)
                    .offset(x: 3, y: 7)
            }
        }
    }
    
    func getTextHeight(for text: String, in width: CGFloat) -> CGFloat {
        let textView = UITextView()
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: 14)
        let size = textView.sizeThatFits(CGSize(width: width - 32, height: CGFloat.greatestFiniteMagnitude))
        return size.height + 30 // Adding padding
    }
}

#Preview {
    FlowComponentView(speakingStructure: .aida, index: 1, showTextBox: .constant(true))
}
