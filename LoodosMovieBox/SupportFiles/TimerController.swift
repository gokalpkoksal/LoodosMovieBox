//
//  TimerController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 5.05.2022.
//

import Foundation

protocol TimerProtocol {
    func startTimer(interval: TimeInterval, tick: @escaping () -> Bool)
}

class TimerController: TimerProtocol {
    
    func startTimer(interval: TimeInterval, tick: @escaping () -> Bool) {
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            let finished = tick()
            if finished { timer.invalidate() }
        }
    }
    
}
