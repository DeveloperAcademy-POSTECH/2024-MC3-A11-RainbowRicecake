//
//  Date + Extension.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/30/24.
//

import Foundation

// Date 에서 날짜 형식 받아오는 메소드 추가
extension Date {
    public func getYMDDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        
        let result = formatter.string(from: self)
        return result
    }
    
    public func calcDDays() -> Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: Date(), to: self).day!
    }
}
