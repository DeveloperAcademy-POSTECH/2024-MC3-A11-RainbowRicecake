//
//  ScriptPracticeView.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/30/24.
//

import SwiftUI

struct ScriptPracticeView: View {
    @State private var elapsedTime: CGFloat = 0
    
    @Binding var isPresented: Bool
    
    let time: Int = 330
    let isTopicSelected: Bool
    
    init(isPresented: Binding<Bool>, isTopicSelected: Bool) {
        self._isPresented = isPresented
        self.isTopicSelected = isTopicSelected
        
        let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = UIColor(Color.clear)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    Spacer(minLength: 30)
                    
                    ForEach(structureSectionSample, id: \.self) { section in
                        StructureSectionView(title: section.topContent, textBody: section.bodyContent, isScript: section.isScript)
                    }
                    
                    Spacer(minLength: 180)
                }
                // TODO: Nav bar 스크롤 시 색 바뀜, 수정 필요
                .overlay(alignment: .top) {
                    ZStack(alignment: .top) {
                        LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom)
                            .frame(height: 100)
                        
                        PromptGuageView(time: time, elapsedTime: $elapsedTime)
                            .padding(.horizontal, 20)
                    }
                }
                .overlay(alignment: .bottom) {
                    ZStack(alignment: .bottom) {
                        LinearGradient(colors: [.white, .clear], startPoint: .center, endPoint: .top)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        .padding(.bottom, 50)
                    }
                    .frame(height: 250)
                }
            }
            .navigationTitle("프롬프트")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !self.isTopicSelected {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            // TODO: 기능 구현 필요
                            self.isPresented = false
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ScriptPracticeView(isPresented: .constant(true), isTopicSelected: false)
}

