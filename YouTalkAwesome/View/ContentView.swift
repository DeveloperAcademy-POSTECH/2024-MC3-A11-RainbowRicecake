//
//  ContentView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/26/24.
//

import SwiftUI

struct ContentView: View {

    //탭바 배경을 흰색으로, 투명하지 않게
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = appearance
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
