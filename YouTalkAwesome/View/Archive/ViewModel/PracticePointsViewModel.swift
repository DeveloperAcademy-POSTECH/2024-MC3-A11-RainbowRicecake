//
//  PracticePointViewModel.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 8/1/24.
//
import SwiftUI

class PracticePointsViewModel: ObservableObject {
    @AppStorage("practicePointsJson") private var practicePointsJson: String = "{}"
    @Published var practicePoints: [String: Int] = [:]
    
    init() {
        loadUserDictionary()
    }
    
    func loadUserDictionary() {
        if let jsonData = practicePointsJson.data(using: .utf8),
           let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Int] {
            practicePoints = dictionary
        }
    }
    
    func saveUserDictionary() {
        if let jsonData = try? JSONSerialization.data(withJSONObject: practicePoints, options: []),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            practicePointsJson = jsonString
        }
    }
    
    // 키에 따라 포인트를 1씩 추가하기
    func addPoint(key: String) {
        if let currentPoints = practicePoints[key] {
            practicePoints[key] = currentPoints + 1
        } else {
            practicePoints[key] = 1
        }
        saveUserDictionary()
    }
    
    // 키에 따라 포인트를 가져오기
    func getPoint(key: String) -> Int {
        return practicePoints[key] ?? 0
    }
    
    //테스트할때 쓸까 싶어서 만들어둠
    func clearUserDictionary() {
        practicePoints = [:] // 딕셔너리 초기화
        practicePointsJson = "{}" // 저장된 데이터 초기화
    }
}
