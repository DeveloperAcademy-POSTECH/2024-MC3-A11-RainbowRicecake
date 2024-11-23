//
//  ScriptPracticeView.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/30/24.
//

import SwiftUI

struct ScriptPracticeView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    
    @State private var vm: ScriptPracticeViewModel
    
    @Binding var isPresented: Bool
    
    @State private var audioManager: AudioManager = .init()
    
    @State private var isFirstSettingForPractice: Bool = true
    
    let isTopicSelected: Bool
    
    var structureSections: [StructureSection]
    
    var selectedStructure: SpeakingStructure
    
    init(isPresented: Binding<Bool>, isTopicSelected: Bool, time: Int, structureSections: [StructureSection], selectedStructure: SpeakingStructure) {
        let vm = ScriptPracticeViewModel(time: time)
        self._isPresented = isPresented
        self.isTopicSelected = isTopicSelected
        self.vm = vm
        self.structureSections = structureSections
        self.selectedStructure = selectedStructure
        
        UINavigationBar.appearance().backgroundColor = .clear
        
        let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = UIColor(Color.clear)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
    
    var body: some View {
            VStack {
                if !isTopicSelected {
                    HStack {
                        Spacer()
                        Text("프롬프트")
                            .customFont(.body1_bold)
                        Spacer()
                    }
                    .overlay(alignment: .trailing) {
                        Button {
                            self.isPresented = false
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 23, height: 23)
                                .foregroundStyle(.bk)
                        }
                        .padding(.trailing, 11)
                    }
                    .padding(.vertical, 10)
                }
                
                ScrollView {
                    VStack {
                        Spacer(minLength: 30)
                        ForEach(structureSections, id: \.self) { section in
                            StructureSectionView(topContent: section.topContent, bottomContent: section.bodyContent, isScript: section.isScript)
                        }
                        
                        Spacer(minLength: 180)
                    }
                    .offset(y: vm.yOffset)
                    .background {
                        GeometryReader { proxy in
                            VStack {}
                                .onChange(of: vm.currentTime) { before, after in
                                    if !self.isTopicSelected {
                                        if vm.currentTime == 0 {
                                            vm.isTimerEnd = true
                                            vm.stopTimer()
                                        }
                                        
                                        withAnimation(.linear) {
                                            let elapsedTime = CGFloat(vm.time - vm.currentTime) / CGFloat(vm.time)
                                            let pausedOffset = (-proxy.size.height + 400) * (elapsedTime)
                                            vm.yOffset = pausedOffset
                                        }
                                    }
                                }
                        }
                    }
                }
                .scrollDisabled( !self.isTopicSelected )
                .overlay(alignment: .top) {
                    ZStack(alignment: .top) {
                        LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom)
                            .frame(height: 100)
                        
                        PromptGuageView(currentTime: vm.currentTime, entireTime: vm.time)
                            .padding(.horizontal, 20)
                    }
                }
                .overlay(alignment: .bottom) {
                    ZStack(alignment: .bottom) {
                        LinearGradient(colors: [.white, .clear], startPoint: .center, endPoint: .top)
                            .allowsHitTesting(false)
                        
                        if self.isTopicSelected {
                            Button {
                                if isFirstSettingForPractice {
                                    self.vm.makeTimer()
                                    self.vm.startTimer()
                                    self.audioManager.startRecording()
                                    
                                    isFirstSettingForPractice = false
                                } else {
                                    self.vm.stopTimer()
                                    self.audioManager.stopRecording()
                                    
                                    coordinator.push(.SpeechPracticeComplete(standardTime: self.vm.time, elapsedTime: self.vm.currentTime, structure: self.selectedStructure, section: structureSections))
                                }
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundStyle(.main)
                                        .frame(height: 54)
                                    
                                    Text(isFirstSettingForPractice ? "시작" : "완료")
                                        .foregroundStyle(.white)
                                        .customFont(.body1_bold)
                                }
                                .padding(.bottom, 53)
                            }
                            .padding(.horizontal, 20)
                        } else {
                            Button {
                                if vm.isTimerPlaying {
                                    vm.stopTimer()
                                } else {
                                    if vm.isTimerEnd {
                                        vm.resetModel()
                                    }
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
                            .foregroundStyle(.main)
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
                                .foregroundStyle(.bk)
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarBackButtonHidden()
            .onAppear {
                self.audioManager.prepareAudio()
            }
    }
}
