//
//  CGContext.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 8/24/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import CoreGraphics

public extension CGContextRef {
    func strokeEllipseInRect(rect:CGRect) {
        CGContextStrokeEllipseInRect(self, rect)
    }

    func strokeLine(points:[CGPoint]) {
        points.withUnsafeBufferPointer {
            (p:UnsafeBufferPointer<CGPoint>) -> Void in
            CGContextStrokeLineSegments(self, p.baseAddress, UInt(points.count))
        }
    }

    func strokeLine(p1:CGPoint, _ p2:CGPoint) {
        self.strokeLine([p1, p2])
    }

    func fillCircle(#center:CGPoint, radius:CGFloat) {
        let rect = CGRect(center:center, size:CGSize(width:radius * 2, height:radius * 2))
        CGContextFillEllipseInRect(self, rect)
    }

#if os(OSX)
    func withColor(color:NSColor, block:() -> Void) {
        CGContextSaveGState(self)
        color.set()
        block()
        CGContextRestoreGState(self)
    }
#endif

}
