//
//  ScrollOffsetKey.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 8/2/24.
//

import SwiftUI

/**
 스크롤 변위값 구하는 Preference key
 */
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
