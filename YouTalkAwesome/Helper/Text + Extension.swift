//
//  Text + Extension.swift
//  YouTalkAwesome
//
//  Created by 최하늘 on 8/1/24.
//

import SwiftUI

// 폰트, 자간, 행간 값을 지정하는 CustomFont struct
struct CustomFont {
    let font: Font
    let kerning: CGFloat
    let lineSpacing: CGFloat
    
    // MARK: Point (Rubik)
    static let point1 = CustomFont(font: .custom("Rubik-Bold", size: 48), kerning: -0.4, lineSpacing: 24.0)
    static let point2 = CustomFont(font: .custom("Rubik-Bold", size: 40), kerning: -0.4, lineSpacing: 20.0)
    static let point3 = CustomFont(font: .custom("Rubik-Bold", size: 32), kerning: -0.4, lineSpacing: 16.0)
    static let point4 = CustomFont(font: .custom("Rubik-Bold", size: 20), kerning: -0.4, lineSpacing: 10.0)
    static let point5 = CustomFont(font: .custom("Rubik-Bold", size: 16), kerning: -0.4, lineSpacing: 8.0)
    
    // MARK: Title (Pretendard)
    static let title1_light = CustomFont(font: .custom("Pretendard-Medium", size: 30), kerning: -0.4, lineSpacing: 17.0)
    static let title1_bold = CustomFont(font: .custom("Pretendard-SemiBold", size: 30), kerning: -0.4, lineSpacing: 17.0)
    
    static let title2_light = CustomFont(font: .custom("Pretendard-Regular", size: 28), kerning: -0.4, lineSpacing: 14.0)
    static let title2_bold = CustomFont(font: .custom("Pretendard-Medium", size: 28), kerning: -0.4, lineSpacing: 14.0)
    
    static let title3_light = CustomFont(font: .custom("Pretendard-Regular", size: 24), kerning: -0.4, lineSpacing: 12.0)
    static let title3_bold = CustomFont(font: .custom("Pretendard-Medium", size: 24), kerning: -0.4, lineSpacing: 12.0)
    
    static let title4_light = CustomFont(font: .custom("Pretendard-Light", size: 20), kerning: -0.4, lineSpacing: 10.0)
    static let title4_bold = CustomFont(font: .custom("Pretendard-SemiBold", size: 20), kerning: -0.4, lineSpacing: 10.0)
    
    // MARK: Body (Pretendard)
    static let body1_light = CustomFont(font: .custom("Pretendard-Regular", size: 18), kerning: -1.0, lineSpacing: 10.0)
    static let body1_bold = CustomFont(font: .custom("Pretendard-SemiBold", size: 18), kerning: -1.0, lineSpacing: 6.0)
    
    static let body2_light = CustomFont(font: .custom("Pretendard-Regular", size: 17), kerning: 0.4, lineSpacing: 12.0)
    static let body2_light2 = CustomFont(font: .custom("Pretendard-Regular", size: 17), kerning: 0.0, lineSpacing: 10.0)
    static let body2_bold = CustomFont(font: .custom("Pretendard-Medium", size: 17), kerning: 0.4, lineSpacing: 12.0)
    
    static let body3_light = CustomFont(font: .custom("Pretendard-Regular", size: 16), kerning: -0.4, lineSpacing: 8.0)
    static let body3_bold = CustomFont(font: .custom("Pretendard-Medium", size: 16), kerning: -0.4, lineSpacing: 8.0)
    
    static let body4_light = CustomFont(font: .custom("Pretendard-Regular", size: 15), kerning: -0.4, lineSpacing: 12.0)
    
    static let body5_light = CustomFont(font: .custom("Pretendard-Regular", size: 14), kerning: 0.4, lineSpacing: 7.0)
    static let body5_bold = CustomFont(font: .custom("Pretendard-SemiBold", size: 14), kerning: 0.4, lineSpacing: 7.0)
    
    // MARK: Caption (Pretendard)
    static let caption1_light = CustomFont(font: .custom("Pretendard-Regular", size: 14), kerning: -0.4, lineSpacing: 7.0)
    static let caption1_bold = CustomFont(font: .custom("Pretendard-SemiBold", size: 14), kerning: -0.4, lineSpacing: 7.0)
    
    static let caption2_light = CustomFont(font: .custom("Pretendard-Regular", size: 12), kerning: -0.4, lineSpacing: 7.0)
}

// 자간, 행간 값을 설정할 수 있도록 Text를 extension
extension Text {
    func customFont(_ customFont: CustomFont) -> some View {
        self
            .font(customFont.font)
            .kerning(customFont.kerning)
            .lineSpacing(customFont.lineSpacing)
    }
}
