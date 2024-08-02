//
//  ArchiveSegmentView.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 8/2/24.
//

import SwiftUI



enum SelectedView {
    case answeredQuestion
    case writtenScript
}

struct ArchiveSegmentView: View {
    @Binding var selectedView: SelectedView
    
    @Namespace var namespace
    
    var body: some View {
        HStack {
            Spacer()
            Text("답변한 질문")
                .customFont(.body2_bold)
                .foregroundStyle(.gray3)
                .padding(.vertical, 10)
                .padding(.horizontal, 5)
                .overlay(alignment: .bottom) {
                    if selectedView == .answeredQuestion {
                        Capsule()
                            .matchedGeometryEffect(id: "selection", in: namespace)
                            .frame(height: 3)
                            .foregroundStyle(.main)
                    }
                }
                .onTapGesture {
                    withAnimation {
                        selectedView = .answeredQuestion
                    }
                }
            Spacer()
            Spacer()
            Text("작성한 대본")
                .customFont(.body2_bold)
                .foregroundStyle(.gray3)
                .padding(.vertical, 10)
                .padding(.horizontal, 5)
                .overlay(alignment: .bottom) {
                    if selectedView == .writtenScript {
                        Capsule()
                            .matchedGeometryEffect(id: "selection", in: namespace)
                            .frame(height: 3)
                            .foregroundStyle(.main)
                    }
                }
                .onTapGesture {
                    withAnimation {
                        selectedView = .writtenScript
                    }
                }

            Spacer()
        }
    }
}

