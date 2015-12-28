//
//  RoundButton.swift
//  SleepyBaby
//
//  Created by Max von Webel on 22.12.15.
//  Copyright © 2015 Max. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        let bounds = self.bounds
        let cornerRadius = min(bounds.width / 2.0, bounds.height / 2.0)
        self.layer.cornerRadius = cornerRadius
    }
}
