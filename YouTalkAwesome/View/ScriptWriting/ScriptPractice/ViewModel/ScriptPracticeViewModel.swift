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
    var yOffset: CGFloat = 0
    var isTimerEnd: Bool = false
    
    init(time: Int) {
        self.time = time * 10
        self.currentTime = time * 10
    }
    
    public func makeTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.currentTime -= 1
        }
    }
    
    public func startTimer() {
        self.currentTime += 1
        self.isTimerPlaying = true
        if let timer = self.timer {
            RunLoop.main.add(timer, forMode: .common)
            timer.fire()
        }
    }
    
    public func stopTimer() {
        self.timer?.invalidate()
        self.isTimerPlaying = false
    }
    
    public func resetModel() {
        self.currentTime = self.time
        self.isTimerPlaying = false
        self.isTimerEnd = false
        self.yOffset = 0
    }
    
    public func timeToString() -> String {
        let realTime = time / 10
        let min = realTime / 60
        let sec = realTime % 60
        return "\(min)분 \(sec)초"
    }
    
    public func calcElapsedTime() -> String {
        let realTime = time / 10
        let realCurrentTime = currentTime / 10
        
        if realCurrentTime == 0 {
            return timeToString()
        } else {
            let elapsedTime = -realCurrentTime + realTime
            let min = elapsedTime / 60
            let sec = elapsedTime % 60
            
            return "\(min)분 \(sec)초"
        }
    }
}
