//
//  FlowView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/30/24.
//

import SwiftUI

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
                        .customFont(.body1_bold)
                        .foregroundStyle(speakingStructure.color)
                    Text("\(speakingStructure.componentDescriptions[index])")
                        .customFont(.caption1_light)
                        .foregroundStyle(Color.gray2)
                        .padding(.bottom, showTextBox ? 0 : 10)
                }
                if showTextBox {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray3, lineWidth: 1)
                        .fill(Color.wh)
                        .overlay(
                            Text("\(speakingStructure.componentExamples[index])")
                                .customFont(.body4_light)
                                .padding()
                                .fixedSize(horizontal: false, vertical: true),
                            alignment: .topLeading
                        )
                        .frame(height: getTextHeight(for: speakingStructure.componentExamples[index], in: UIScreen.main.bounds.width))
                        .padding(.bottom)
                }
            }
            Spacer()
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
        let customFont = UIFont(name: "Pretendard-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12.0 // 원하는 줄 간격 값
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: customFont
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)

        textView.attributedText = attributedString

        let size = textView.sizeThatFits(CGSize(width: width - 32, height: CGFloat.greatestFiniteMagnitude))
        return size.height + 32 // 패딩 추가
    }

}

#Preview {
    FlowComponentView(speakingStructure: .aida, index: 1, showTextBox: .constant(true))
}
