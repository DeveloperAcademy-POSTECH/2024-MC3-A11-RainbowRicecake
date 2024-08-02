//
//  ArchiveView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/29/24.
//

import SwiftUI
import UIKit

struct ArchiveView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @StateObject private var viewModel: ArchiveViewModel = .init()
    
    @State private var selectedView: SelectedView = .writtenScript
    @State private var scrollObservableViewHeight: CGFloat = 0
    
    let width: CGFloat = (UIScreen.main.bounds.width - 42) / 3
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(pinnedViews: .sectionHeaders) {
                    historyView
                    
                    Section {
                        switch selectedView {
                        case .answeredQuestion:
                            answeredQuestionView
                        case .writtenScript:
                            writtenScript
                        }
                    } header: {
                        VStack(spacing: 0) {
                            scrollObservableView
                            
                            ArchiveSegmentView(selectedView: $selectedView)
                                .background(.white)
                        }
                    }
                }
                .onPreferenceChange(ScrollOffsetKey.self) { value in
                    if value <= safeAreaInsets.top - 10 {
                        withAnimation {
                            self.scrollObservableViewHeight = safeAreaInsets.top
                        }
                    } else {
                        self.scrollObservableViewHeight = 0
                    }
                    viewModel.setOffset(value)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
    }
    
    private var historyView: some View {
        ZStack {
            Color.bg
            
            VStack {
                HStack(spacing: 0) {
                    VStack {
                        Image(systemName: "flowchart.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.gray5)
                        
                        Text("말하기 구조 학습")
                            .customFont(.caption1_bold)
                            .foregroundStyle(.gray3)
                        Text("16")
                            .customFont(.title3_bold)
                            .foregroundStyle(.main)
                    }
                    .frame(width: width)
                    
                    Capsule()
                        .frame(width: 1)
                        .foregroundStyle(.gray5)

                    VStack {
                        Image(systemName: "questionmark.bubble.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.gray5)
                        
                        Text("답변한 질문")
                            .customFont(.caption1_bold)
                            .foregroundStyle(.gray3)
                        Text("6")
                            .customFont(.title3_bold)
                            .foregroundStyle(.main)
                    }
                    .frame(width: width)

                    Capsule()
                        .frame(width: 1)
                        .foregroundStyle(.gray5)

                    VStack {
                        Image(systemName: "applescript.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.gray5)
                        
                        Text("작성한 대본")
                            .customFont(.caption1_bold)
                            .foregroundStyle(.gray3)
                        Text("3")
                            .customFont(.title3_bold)
                            .foregroundStyle(.main)
                    }
                    .frame(width: width)
                }
                
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 72)
                            .foregroundStyle(.white)
                            .shadow(radius: 10)
                        
                        HStack {
                            Text("나의 말하기 구조 학습 현황")
                                .customFont(.title4_bold)
                                .foregroundStyle(.gray3)
                            Spacer()
                            Image(systemName: "arrow.right.circle.fill")
                                .resizable()
                                .foregroundStyle(.main)
                                .frame(width: 32, height: 32)
                        }
                        .padding(.leading, 33)
                        .padding(.trailing, 24)
                    }
                }
                .padding(.vertical, 32)
            }
            .padding(.horizontal, 20)
            .padding(.top, 100)
            
        }
    }

    private var answeredQuestionView: some View {
        ForEach(0..<10, id: \.self) { _ in
            TopicBubbleView(topicContent: "아카데미에서 가장 잘생긴 사람은?", lsName: "STAR", isWideType: true)
                .padding(.horizontal, 20)
                .padding(.vertical, 32)
        }
    }
    
    private var writtenScript: some View {
        // TODO: 데이터 연결하기
        LazyVGrid(columns: [.init(spacing: 24), .init(spacing: 0)], spacing: 32) {
            ForEach(0..<10, id: \.self) { _ in
                ScriptRectangleView(isThisForAdding: false, leftDay: "4", scriptTitle: "아카데미 수료", isDone: false)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    private var scrollObservableView: some View {
        GeometryReader { proxy in
            let offsetY = proxy.frame(in: .global).origin.y
            Color.white
                .preference(
                    key: ScrollOffsetKey.self,
                    value: offsetY
                )
                .onAppear { // 나타날때 뷰의 최초위치를 저장하는 로직
                    viewModel.setOriginOffset(offsetY)
                }
        }
        .frame(height: self.scrollObservableViewHeight)
    }
    

}

#Preview {
    ArchiveView()
}

