//
//  ContentView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/26/24.
//

import SwiftUI

struct ContentView: View {

    //탭바 배경을 흰색으로, 투명하지 않게 초기화 함
    //TODO: 처음 화면에서는 잘 반영이 되는데 화면 전이되면 풀림 -> 무니 화면에 적용된 코드 참고해서 전체 적용 예정
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = appearance
    }

    var body: some View {
        TabView {
            QuizView()
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
