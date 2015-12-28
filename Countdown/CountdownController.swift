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
    func countdownEvent(event: CountdownController.Event)
}

class CountdownController {
    enum State {
        case Counting
        case Idle
    }

    static let placeholder = "WMR #99"
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

    func extend(time: NSTimeInterval) {
        endDate = endDate! + time
        tick(timer!)
    }

    @objc func tick(timer: NSTimer) {
        let timeLeft = endDate != nil ? round(endDate! - NSDate()) : 0.0

        if timeLeft <= 0.0 {
            stop()
            return
        }

        text = timeLeft.formatedString(includeSeconds: true)

        tick(timeLeft: Int(timeLeft))
    }
}

extension CountdownController {
    enum Event {
        case Vote
        case NearlyOutOfTime
    }

    typealias TimeRange = Range<Int>

    struct Times {
        static let Vote: TimeRange = 28...30
        static let NearlyOutOfTime: TimeRange = 0...10
    }

    func tick(timeLeft timeLeft: Int) {
        let event: Event?
        if Times.Vote.contains(timeLeft) {
            event = .Vote
        } else if Times.NearlyOutOfTime.contains(timeLeft) {
            event = .NearlyOutOfTime
        } else {
            event = nil
        }

        if let event = event {
            delegate?.countdownEvent(event)
        }
    }
}