//
//  ViewController.swift
//  Countdown
//
//  Created by Max von Webel on 28.12.15.
//  Copyright © 2015 Max von Webel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let countdownController = CountdownController()

    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var startButton: RoundButton!
    @IBOutlet weak var stopButton: RoundButton!
    @IBOutlet weak var extendButton: RoundButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.countdownLabel.font = self.countdownLabel.font.monospacedDigitFont
        countdownController.delegate = self

        if let contentView = scrollView.subviews.first {
            contentView.backgroundColor = UIColor.clearColor()
            contentView.translatesAutoresizingMaskIntoConstraints = true
        }

        let leftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("reduceTimeSwipe:"))
        leftGestureRecognizer.direction = .Left
        scrollView.addGestureRecognizer(leftGestureRecognizer)

        let rightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("extendTimeSwipe:"))
        rightGestureRecognizer.direction = .Right
        scrollView.addGestureRecognizer(rightGestureRecognizer)

        scrollView.pagingEnabled = true

        layout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layout()
    }

    func layout() {
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: scrollView.bounds.height * 2.0)

        let contentView = scrollView.subviews.first!

        let origin = CGPoint(x: 0.0, y: scrollView.bounds.height)
        contentView.frame = CGRect(origin: origin, size: scrollView.bounds.size)
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

extension ViewController {
    @objc func reduceTimeSwipe(gestureRecognizer: UIGestureRecognizer) {
        if countdownController.state == .Counting {
            countdownController.extend(-15)
        }
    }

    @objc func extendTimeSwipe(gestureRecognizer: UIGestureRecognizer) {
        if countdownController.state == .Counting {
            countdownController.extend(15)
        }
    }
}

extension ViewController {
    func hidePannel() {
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }

    @IBAction func tappedStart(sender: AnyObject) {
        countdownController.start()
        hidePannel()
    }
    
    @IBAction func tappedStop(sender: AnyObject) {
        countdownController.stop()
        hidePannel()
    }

    @IBAction func tappedExtend(sender: AnyObject) {
        countdownController.extend(60)
    }
}

extension ViewController: CountDownControllerDelegate {
    func updateCountdown(countdownString: String) {
        self.countdownLabel.text = countdownString
    }

    func countdownStateChanged(newState: CountdownController.State) {
        let hideStart = newState != .Idle
        startButton.hidden = hideStart
        stopButton.hidden = !hideStart
        extendButton.hidden = !hideStart
    }

    func countdownEvent(event: CountdownController.Event) {
        let color: UIColor
        switch event {
        case .NearlyOutOfTime:
            color = UIColor.redColor()
        case .Vote:
            color = UIColor.orangeColor()
        }

        let initialColor = view.backgroundColor
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.backgroundColor = color
            }) { (completed) -> Void in
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.view.backgroundColor = initialColor
                })
        }
    }
}
