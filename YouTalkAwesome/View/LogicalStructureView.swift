//
//  LogicalStructureView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 7/29/24.
//

import SwiftUI

struct LogicalStructureView: View {
    var body: some View {
        VStack {
            HStack {
                Text("논리 구조를 연습해보세요")
                    .font(.largeTitle)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                HStack {
                    Rectangle()
                        .fill(Color.white)
                        .stroke(Color.black)
                        .frame(width: 250, height: 250)
                    Rectangle()
                        .fill(Color.white)
                        .stroke(Color.black)
                        .frame(width: 250, height: 250)
                    Rectangle()
                        .fill(Color.white)
                        .stroke(Color.black)
                        .frame(width: 250, height: 250)
                }
            }

            VStack {
                HStack {
                    Text("청중의 마음을 움직인 연설")
                    Spacer()
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        Rectangle()
                            .fill(Color.white)
                            .stroke(Color.black)
                            .frame(width: 200, height: 120)
                        Rectangle()
                            .fill(Color.white)
                            .stroke(Color.black)
                            .frame(width: 200, height: 120)
                        Rectangle()
                            .fill(Color.white)
                            .stroke(Color.black)
                            .frame(width: 200, height: 120)
                    }
                }
            }
            
            VStack {
                HStack {
                    Text("커리어 인터뷰")
                    Spacer()
                }
                ScrollView(.horizontal) {
                    HStack {
                        Rectangle()
                            .fill(Color.white)
                            .stroke(Color.black)
                            .frame(width: 200, height: 120)
                        Rectangle()
                            .fill(Color.white)
                            .stroke(Color.black)
                            .frame(width: 200, height: 120)
                        Rectangle()
                            .fill(Color.white)
                            .stroke(Color.black)
                            .frame(width: 200, height: 120)
                    }
                }
            }
            
        }
        .padding()
    }
}

#Preview {
    LogicalStructureView()
}
