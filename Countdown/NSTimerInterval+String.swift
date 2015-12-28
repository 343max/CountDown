//
//  Number+TimeIntervalFormat.swift
//  SleepyBaby
//
//  Created by Max von Webel on 25.12.15.
//  Copyright © 2015 Max. All rights reserved.
//

import Foundation

extension NSTimeInterval {
    func formatedString(includeSeconds includeSeconds: Bool) -> String {
        let seconds = Int(self) % 60
        let minutes = (Int(self) / 60) % 60

        if includeSeconds {
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return String(format: "%02d", minutes)
        }
    }
}
