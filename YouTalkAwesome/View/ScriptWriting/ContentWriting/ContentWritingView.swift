//
//  ContentWritingView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 8/1/24.
//

import SwiftUI

struct ContentWritingView: View {
    
    var topic : String
    var selectedStructure : SpeakingStructure
    var designatedDate : Date? // 나중에 계산해야한다.
    var expecteLeadTime : String? //나중에 계산해야한다.
    
    @State private var progress : Int = 1
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                Text(topic)
                    .customFont(.title4_bold)
                    .padding()
                    .padding(.top, 80)
                
                HStack {
                    Label(
                        title: {
                            Text("2024. 08. 05")
                                .customFont(.body2_light)
                        },
                        icon: { Image(systemName: "calendar") }
                    )
                    
                    Label(
                        title: {
                            Text("5분 30초")
                                .customFont(.body2_light)
                        },
                        icon: { Image(systemName: "clock") }
                    )
                    
                    Spacer()
                }
                .foregroundColor(Color.gray3).padding([.horizontal, .bottom])
                
            }
            .frame(maxWidth: .infinity)
            .background {
                Color.bg
            }
            
            VStack {
                Image("\(selectedStructure.rawValue)_\(progress)")
                    .padding(10)
            }
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                } label: {
                    Text("완료")
                        .font(.system(size: 17)) //별도 customfont 지정 없음
                        .foregroundStyle(.main)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentWritingView(topic: "AI를 활용한 UX디자인", selectedStructure: .prep)
    }
}
