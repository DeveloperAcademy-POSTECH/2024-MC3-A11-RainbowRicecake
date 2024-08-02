//
//  ScriptRectangleView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/31/24.
//

import SwiftUI

struct ScriptRectangleView: View {
    let width: CGFloat = 180
    let height: CGFloat = 220
    
    var isThisForAdding: Bool
    var leftDay : String?
    var scriptTitle: String?
    var isDone : Bool?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.wh)
            .frame(width: width, height: height)
            .shadow(radius: 5)
            .overlay {
                Image(.clip)
                    .offset(y: -( (height + 10) / 2))
            }
            .overlay {
                if isThisForAdding {
                    VStack {
                        Text("새로운 대본 추가하기")
                            .font(.system(size: 18)) //별도 customfont 지정 없음
                            .foregroundStyle(.gray4)
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundColor(.gray4)
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text("D - \(leftDay!)")
                            .customFont(.title4_light)
                            .foregroundStyle(.gray3)
                        Text(scriptTitle!)
                            .customFont(.title3_bold)
                        Spacer()
                        HStack {
                            Spacer()
                            Text(isDone! ? "작성완료" : "작성 중···")
                                .customFont(.caption1_bold)
                                .foregroundStyle(.gray3)
                        }
                        
                    }
                    .frame(width: 140, height: 150)
                }
            }
    }
}

#Preview {
    ScrollView(.horizontal) {
        HStack {
            ScriptRectangleView(isThisForAdding: true)
            ScriptRectangleView(isThisForAdding: false, leftDay: "5", scriptTitle: "애플 리뷰 준비", isDone: false)
        }.padding()
    }
    .scrollIndicators(.hidden)
}
