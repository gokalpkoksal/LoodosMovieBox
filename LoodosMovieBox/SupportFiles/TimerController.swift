//
//  TimerController.swift
//  LoodosMovieBox
//
//  Created by Gökalp Köksal on 5.05.2022.
//

import Foundation

protocol TimerProtocol {
    func startTimer(durationInSeconds: Double, completion: @escaping () -> Void)
}

class TimerController: TimerProtocol {
    
    private let timeInterval = TimeInterval(1)
    
    func startTimer(durationInSeconds: Double, completion: @escaping () -> Void) {
        var durationInSeconds = durationInSeconds
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            if durationInSeconds == 0 {
                timer.invalidate()
                completion()
            } else {
                durationInSeconds -= 1
            }
        }
    }
    
}
