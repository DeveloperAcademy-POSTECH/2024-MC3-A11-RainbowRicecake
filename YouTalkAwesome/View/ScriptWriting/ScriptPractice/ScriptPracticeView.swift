//
//  ScriptPracticeView.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/30/24.
//

import SwiftUI

struct ScriptPracticeView: View {
    @State private var vm: ScriptPracticeViewModel
    
    @Binding var isPresented: Bool
    
    @Binding var audioManager: AudioManager
    
    let isTopicSelected: Bool
    
    init(isPresented: Binding<Bool>, isTopicSelected: Bool, vm: ScriptPracticeViewModel, audioManager: Binding<AudioManager>) {
        self._isPresented = isPresented
        self.isTopicSelected = isTopicSelected
        self.vm = vm
        self._audioManager = audioManager
        
        let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = UIColor(Color.clear)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            // TODO: 자동 scroll 수정 예정
            ScrollViewReader { proxy in
                VStack {
                    ScrollView {
                        Spacer(minLength: 30)
                        
                        ForEach(structureSectionSample, id: \.self) { section in
                            StructureSectionView(topContent: section.topContent, bottomContent: section.bodyContent, isScript: section.isScript)
                        }
                        
                        Spacer(minLength: 180)
                    }
                    .scrollIndicators(.hidden)
                    .overlay(alignment: .top) {
                        ZStack(alignment: .top) {
                            LinearGradient(colors: [.wh, .clear], startPoint: .top, endPoint: .bottom)
                                .frame(height: 100)
                            
                            PromptGuageView(currentTime: vm.currentTime, entireTime: vm.time)
                                .padding(.horizontal, 20)
                        }
                    }
                    .overlay(alignment: .bottom) {
                        ZStack(alignment: .bottom) {
                            LinearGradient(colors: [.wh, .clear], startPoint: .center, endPoint: .top)
                            
                            if self.isTopicSelected {
                                Button {
                                    
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .frame(height: 54)
                                        
                                        Text("완료")
                                            .foregroundStyle(.wh)
                                    }
                                    .padding(.bottom, 53)
                                }
                                .padding(.horizontal, 20)
                                
                            } else {
                                Button {
                                    if vm.isTimerPlaying {
                                        vm.stopTimer()
                                    } else {
                                        self.vm.makeTimer()
                                        self.vm.startTimer()
                                    }
                                } label: {
                                    if vm.isTimerPlaying {
                                        Image(systemName: "pause.circle.fill")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                    } else {
                                        Image(systemName: "play.circle.fill")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                    }
                                }
                                .padding(.bottom, 50)
                            }
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
        .onAppear {
            if self.isTopicSelected {
                vm.makeTimer()
                vm.startTimer()
                audioManager.startRecording()
            }
        }
    }
}

#Preview {
    ScriptPracticeView(isPresented: .constant(true), isTopicSelected: true, vm: .init(time: 3), audioManager: .constant(AudioManager()))
}

