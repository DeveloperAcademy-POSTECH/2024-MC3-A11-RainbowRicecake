//
//  TestView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 8/1/24.
//

import SwiftUI

struct TestPointView: View {
    @StateObject var practicePointsViewModel = PracticePointsViewModel()
    
    var body: some View {
        VStack {
            Text("Stored Dictionary: \(practicePointsViewModel.practicePoints.description)")
                .padding()
            
            Button(action: {
                practicePointsViewModel.addPoint(key: "PSB")
            }) {
                Text("add Points")
            }
            .padding()
            
            Button(action: {
                // 딕셔너리 데이터를 모두 삭제
                practicePointsViewModel.clearUserDictionary()
            }) {
                Text("Clear Data")
                    .foregroundColor(.red)
            }
            .padding()
        }
    }
}

#Preview {
    TestPointView()
}
