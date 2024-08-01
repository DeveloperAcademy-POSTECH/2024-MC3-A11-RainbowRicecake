//
//  ContentView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/26/24.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .white
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
                    Label("저장소", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
