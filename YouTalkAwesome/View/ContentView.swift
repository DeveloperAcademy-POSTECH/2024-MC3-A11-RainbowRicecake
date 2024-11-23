//
//  ContentView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/26/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appCoordinator: AppCoordinator = .init()
    
    @State private var tabSelection: Int = 0
    
    init() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .wh
    }
    
    var body: some View {
        TabView(selection: $tabSelection) {
            NavigationStack(path: $appCoordinator.speakingStructurePath) {
                SpeakingStructureView()
                    .navigationDestination(for: Screen.self) { screen in
                        appCoordinator.build(screen)
                    }
            }
            .tabItem {
                Label("말하기 구조", systemImage: "text.bubble")
            }
            .tag(0)
            
            NavigationStack(path: $appCoordinator.scriptWritingPath) {
                ScriptWritingView()
                    .navigationDestination(for: Screen.self) { screen in
                        appCoordinator.build(screen)
                    }
            }
            .tabItem {
                Label("대본 작성", systemImage: "doc.append")
            }
            .tag(1)
            
            NavigationStack(path: $appCoordinator.archivePath) {
                ArchiveView()
                    .navigationDestination(for: Screen.self) { screen in
                        appCoordinator.build(screen)
                    }
            }
            .tabItem {
                Label("저장소", systemImage: "person.fill")
            }
            .tag(2)
            
        }
        .tint(.main)
        .navigationBarBackButtonHidden()

        .environmentObject(appCoordinator)
        .onChange(of: tabSelection) { _, newValue in
            switch newValue {
            case 0:
                appCoordinator.currentScreen = .speakingStructure
            case 1:
                appCoordinator.currentScreen = .scriptWriting
            default:
                appCoordinator.currentScreen = .archive
            }
        }
    }
}

#Preview {
    ContentView()
}
