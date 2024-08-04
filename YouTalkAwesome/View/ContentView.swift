//
//  ContentView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/26/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    
//    @Environment(\.modelContext) private var modelContext
//    @StateObject private var appStorageModel = PracticePointsViewModel()
    
    init() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .wh
    }
    
    var body: some View {
        TabView {
            SpeakingStructureView()
                .tabItem {
                    Label("말하기 구조", systemImage: "text.bubble")
                }
            ScriptWritingView()
                .tabItem {
                    Label("대본 작성", systemImage: "doc.append")
                }
            ArchiveView()
                .tabItem {
                    Label("저장소", systemImage: "person.fill")
                }
        }
        .navigationBarBackButtonHidden()
//        .onAppear {
//            appStorageModel.clearUserDictionary()
//            do {
//                try modelContext.delete(model: LogicalSpeakingRecord.self)
//            } catch {
//                print("Failed to clear all Country and City data.")
//            }
//        }
    }
}

#Preview {
    ContentView()
}
