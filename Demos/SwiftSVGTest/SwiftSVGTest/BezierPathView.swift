//
//  BezierPathView.swift
//  SwiftSVGTest
//
//  Created by Jonathan Wight on 8/27/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Cocoa

class BezierPathView: NSView {

    var bezierPath : NSBezierPath?

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        if let bezierPath = bezierPath {
            bezierPath.stroke()
        }
    }
}
