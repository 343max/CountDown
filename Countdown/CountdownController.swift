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
    func countdownStateChanged(newState: CountdownController.State)
}

class CountdownController {
    enum State {
        case Counting
        case Idle
    }

    static let placeholder = "WMR"
    static let duration = NSTimeInterval(5 * 60)
    var endDate: NSDate? {
        didSet {
            state = endDate == nil ? .Idle : .Counting
        }
    }
    var timer: NSTimer?
    var state: State = .Idle {
        didSet {
            delegate?.countdownStateChanged(state)
        }
    }
    var text = CountdownController.placeholder {
        didSet {
            delegate?.updateCountdown(text)
        }
    }

    weak var delegate: CountDownControllerDelegate? {
        didSet {
            delegate?.countdownStateChanged(state)
            delegate?.updateCountdown(text)
        }
    }

    func start() {
        endDate = NSDate(timeIntervalSinceNow: CountdownController.duration)
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("tick:"), userInfo: nil, repeats: true)
        tick(timer!)
    }

    func stop() {
        timer?.invalidate()
        timer = nil

        endDate = nil

        text = CountdownController.placeholder
    }

    func extend() {
        endDate = endDate! + 60
        tick(timer!)
    }

    @objc func tick(timer: NSTimer) {
        let timeLeft = endDate != nil ? endDate! - NSDate() : 0.0

        if timeLeft <= 0.0 {
            stop()
            return
        }

        text = timeLeft.formatedString(includeSeconds: true)
    }
}