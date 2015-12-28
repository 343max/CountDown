//
//  CountdownController.swift
//  Countdown
//
//  Created by Max von Webel on 28.12.15.
//  Copyright © 2015 Max von Webel. All rights reserved.
//

import Foundation

protocol CountDownControllerDelegate: class {
    func updateCountdown(countdownString: String)
}

class CountdownController {
    static let placeholder = "WMR"
    static let duration = NSTimeInterval(60 * 5)
    var endDate: NSDate?
    var timer: NSTimer?

    weak var delegate: CountDownControllerDelegate?

    func reset() {
        endDate = NSDate(timeIntervalSinceNow: CountdownController.duration)
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("tick:"), userInfo: nil, repeats: true)
    }

    func stop() {
        timer?.invalidate()
        timer = nil

        endDate = nil

        delegate?.updateCountdown(CountdownController.placeholder)
    }

    @objc func tick(timer: NSTimer) {
        let timeLeft = endDate != nil ? endDate! - NSDate() : 0.0

        if timeLeft <= 0.0 {
            stop()
            return
        }

        delegate?.updateCountdown(timeLeft.formatedString(includeSeconds: true))
    }
}