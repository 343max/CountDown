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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.countdownLabel.font = self.countdownLabel.font.monospacedDigitFont

        self.countdownLabel.text = CountdownController.placeholder
        countdownController.delegate = self

        if let contentView = scrollView.subviews.first {
            contentView.backgroundColor = UIColor.clearColor()
            contentView.translatesAutoresizingMaskIntoConstraints = true
        }

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
}

extension ViewController: CountDownControllerDelegate {
    func updateCountdown(countdownString: String) {
        self.countdownLabel.text = countdownString
    }
}
