//
//  ExampleTitleView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/29/24.
//

import SwiftUI

struct ExampleTitleView: View {
    var title: String
    
    var body: some View {
        Text(title)
        .customFont(.title4_bold)
    }
}

#Preview {
    ExampleTitleView(title: "청중의 마음을 움직인 연설🎙️")
}
