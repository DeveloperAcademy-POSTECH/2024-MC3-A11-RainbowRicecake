//
//  ScriptPracticeViewModel.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/31/24.
//

import Foundation

@Observable
final class ScriptPracticeViewModel {
    let time: Int
    var currentTime: Int
    var timer: Timer?
    var isTimerPlaying: Bool = false
    
    init(time: Int) {
        self.time = time * 10
        self.currentTime = time * 10
    }
    
    public func makeTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
//            if self.currentTime == 0 {
//                self.timer?.invalidate()
//                self.isTimerPlaying = false
//            }
            self.currentTime -= 1
        }
    }
    
    public func startTimer() {
        self.currentTime += 1
        self.isTimerPlaying = true
        self.timer?.fire()
    }
    
    public func stopTimer() {
        self.timer?.invalidate()
        self.isTimerPlaying = false
    }
}
