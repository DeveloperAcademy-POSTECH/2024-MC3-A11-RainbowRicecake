//
//  ListeningSpeechView.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 8/1/24.
//

import SwiftUI

struct ListeningSpeechView: View {
    @State private var audioManager: AudioManager = .init()
    @State var vm: ScriptPracticeViewModel
    
    @Binding var isPresented: Bool
    
    var sections: [StructureSection]
    
    var body: some View {
        NavigationStack {
            VStack {
                PromptGuageView(currentTime: vm.currentTime, entireTime: vm.time)
                    .padding(.horizontal)
                
                ScrollView {
                    ForEach(sections, id: \.self) { section in
                        StructureSectionView(topContent: section.topContent, bottomContent: section.bodyContent, isScript: section.isScript)
                    }
                    Spacer(minLength: 200)
                }
            }
            .navigationTitle("내 답변 듣기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.isPresented = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .tint(.black)
                }
            }
            .overlay(alignment: .bottom) {
                ZStack(alignment: .bottom) {
                    LinearGradient(colors: [.white, .clear], startPoint: .center, endPoint: .top)
                    
                    Button {
                        if audioManager.isPlaying {
                            vm.stopTimer()
                            audioManager.pauseAudio()
                        } else {
                            vm.makeTimer()
                            vm.startTimer()
                            
                            audioManager.startAudio()
                        }
                    } label: {
                        if audioManager.isPlaying {
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
                .ignoresSafeArea()
                .frame(height: 250)
            }
            .onChange(of: vm.currentTime) {
                if vm.currentTime == 0 {
                    vm.stopTimer()
                    vm.resetModel()
                }
            }
        }
    }
}
