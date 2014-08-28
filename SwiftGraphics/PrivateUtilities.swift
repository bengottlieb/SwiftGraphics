//
//  PrivateUtilities.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 8/27/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Foundation
import CoreGraphics

// Utility code that is used by SwiftGraphics but isn't intended to be used outside of this project
// Some of this code is embarrasing.

extension CGFloat {
    init(_ string:String) {
        self = CGFloat(string._bridgeToObjectiveC().doubleValue)
    }
}

func parseDimension(string:String) -> (CGFloat, String)! {
    let pattern = NSRegularExpression(pattern:"([0-9]+)[ \t]*(px)", options:.CaseInsensitive, error:nil)
    let range = NSMakeRange(0, string._bridgeToObjectiveC().length)
    let match = pattern.firstMatchInString(string, options:NSMatchingOptions(), range:range)
    // TODO: Check for failures
    let scalar = string._bridgeToObjectiveC().substringWithRange(match.rangeAtIndex(0))
    let unit = string._bridgeToObjectiveC().substringWithRange(match.rangeAtIndex(1))
    return (CGFloat(scalar), unit)
}

extension Character {
    // TODO: LOL
    var isLowercase : Bool { get { return contains("abcdefghijklmnopqrstuvwxyz", self) } } 
}

extension NSScanner {

    func scanCGFloat() -> CGFloat? {
        var d:Double = 0
        if self.scanDouble(&d) {
            return CGFloat(d)
        }
        else {
            return nil
        }
    }

    func scanCGPoint() -> CGPoint? {
        let x = scanCGFloat()
        let y = scanCGFloat()
        if x != nil && y != nil {
            return CGPoint(x:x!, y:y!)
        }
        else {
            return nil
        }
    }
}
