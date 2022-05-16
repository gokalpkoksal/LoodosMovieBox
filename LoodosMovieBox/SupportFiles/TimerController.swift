//
//  TimerController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 5.05.2022.
//

import Foundation

protocol TimerProtocol {
    func startTimer(interval: TimeInterval, tick: @escaping () -> Void)
    func stopTimer()
}

class TimerController: TimerProtocol {
    
    var timer: Timer?
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func startTimer(interval: TimeInterval, tick: @escaping () -> Void) {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            tick()
        }
    }
    
}
