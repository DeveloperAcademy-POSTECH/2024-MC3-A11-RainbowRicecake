//
//  ScriptRectangleView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/31/24.
//

import SwiftUI

struct ScriptRectangleView: View {
    let ratio: CGFloat = 180 / 224
    
    var isThisForAdding: Bool
    var leftDay : String?
    var scriptTitle: String?
    var isDone : Bool?
    
    let record: LogicalSpeakingRecord?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.wh)
            .aspectRatio(180/224, contentMode: .fit)
            .shadow(radius: 5)
            .overlay(alignment: .top) {
                Image(.clip)
                    .offset(y: -25)
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
                    VStack(alignment: .leading, spacing: 0) {
                        Text("D - \(days(from: record?.designatedTimestamp ?? Date()))")
                            .customFont(.title4_light)
                            .foregroundStyle(.gray3)
                        Text(scriptTitle!)
                            .customFont(.title3_bold)
                        Spacer()
                        HStack {
                            Spacer()
                            Text(record!.isDone ? "작성완료" : "작성 중···")
                                .customFont(.caption1_bold)
                                .foregroundStyle(.gray3)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                    .padding(.bottom, 24)
//                    .frame(width: 140, height: 150)
                    
                }
            }
    }
    
//    private func calculateDays(date: Date) -> Int {
//
//        let startDate =
//        daysCount = days(from: startDate)
//        let hundred = calendar.date(byAdding: .day, value: 100, to: startDate)
//    }
    
    
    private func days(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: date, to: Date()).day! + 1
    }
}

#Preview {
//    ScrollView(.horizontal) {
//        HStack {
//            ScriptRectangleView(isThisForAdding: true)
//            ScriptRectangleView(isThisForAdding: false, leftDay: "5", scriptTitle: "애플 리뷰 준비", isDone: false)
//        }.padding()
//        
//    }
    
    
    ScriptRectangleView(isThisForAdding: true, leftDay: "5", scriptTitle: "애플 리뷰 준비", isDone: false, record: nil)
}
