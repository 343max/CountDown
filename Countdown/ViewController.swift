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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.countdownLabel.text = CountdownController.placeholder
        countdownController.delegate = self
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

extension ViewController: CountDownControllerDelegate {
    func updateCountdown(countdownString: String) {
        self.countdownLabel.text = countdownString
    }
}
