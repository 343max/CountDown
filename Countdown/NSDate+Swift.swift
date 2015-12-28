//
//  NSDate+Swift.swift
//  SleepyBaby
//
//  Created by Max von Webel on 23.12.15.
//  Copyright © 2015 Max. All rights reserved.
//

import Foundation

extension NSDate: Comparable {

}

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 == rhs.timeIntervalSince1970
}

public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 < rhs.timeIntervalSince1970
}

extension NSDate: Strideable {
    public typealias Stride = NSTimeInterval

    public func distanceTo(other: NSDate) -> NSDate.Stride {
        return other.timeIntervalSinceDate(self)
    }

    public func advancedBy(n: NSDate.Stride) -> Self {
        return self.dateByAddingTimeInterval(n)
    }
}