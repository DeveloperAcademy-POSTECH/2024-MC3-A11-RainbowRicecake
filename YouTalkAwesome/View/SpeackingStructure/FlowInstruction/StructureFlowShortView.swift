//
//  StructureFlowView.swift
//  YouTalkAwesome
//
//  Created by Marty on 11/23/24.
//

import SwiftUI

struct StructureFlowShortView: View {
    var speakingStructure: SpeakingStructure
    @State var showExampleContents: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("\(speakingStructure.rawValue.uppercased()) 알아보기")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<speakingStructure.components.count, id: \.self) { index in
                    FlowComponentView(speakingStructure: speakingStructure, index: index, showTextBox: $showExampleContents)
                }
            }
            .padding(.top, 5)
            .padding(.bottom)
        }
        .padding()
        .toolbarRole(.editor)
    }
}

#Preview {
    NavigationStack {
        StructureFlowShortView(speakingStructure: .prep)
    }
}
