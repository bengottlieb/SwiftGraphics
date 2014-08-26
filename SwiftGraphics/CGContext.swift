//
//  CGContext.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 8/24/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import CoreGraphics

// TODO: This code is mostly experimental, use at your own risk - see TODO.markdown

public extension CGContextRef {

    class func bitmapContext(size:CGSize) -> CGContextRef! {
        let colorspace = CGColorSpaceCreateDeviceRGB()    
        var bitmapInfo = CGBitmapInfo(CGImageAlphaInfo.PremultipliedFirst.toRaw())
        return CGBitmapContextCreate(nil, UInt(size.width), UInt(size.height), 8, UInt(size.width) * 4, colorspace, bitmapInfo)
    }

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

    func fillCircle(circle:Circle) {
        CGContextFillEllipseInRect(self, circle.rect)
    }

    func with(block:() -> Void) {
        CGContextSaveGState(self)
        block()
        CGContextRestoreGState(self)
    }

#if os(OSX)
    func withColor(color:NSColor, block:() -> Void) {
        with {
            CGContextSetStrokeColorWithColor(self, color.CGColor)
            CGContextSetFillColorWithColor(self, color.CGColor)
            block()
        }
    }
#endif
}

public extension CGImageRef {
    var size : CGSize { get { return CGSize(width:CGFloat(CGImageGetWidth(self)), height:CGFloat(CGImageGetHeight(self))) } }
}

#if os(OSX)
public extension CGContextRef {

    var nsimage : NSImage {
        get { 
            let cgimage = CGBitmapContextCreateImage(self)
            let nsimage = NSImage(CGImage:cgimage, size:cgimage.size)
            return nsimage
        }
    }
}
#endif


public extension CGContextRef {

    func strokeCross(rect:CGRect) {
        let (x, y, w, h) = rect.asTuple
    
        let linePoints = [
            CGPoint(x:x - w * 0.5, y:y), CGPoint(x:x + h * 0.5, y:y),
            CGPoint(x:x, y:y - w * 0.5), CGPoint(x:x, y:y + h * 0.5),
        ]
        self.strokeLine(linePoints)
    }

    func strokeSaltire(rect:CGRect) {
        let (x, y, w, h) = rect.asTuple
    
        let linePoints = [
            CGPoint(x:x - w * 0.5, y:y - h * 0.5), CGPoint(x:x + h * 0.5, y:y + w * 0.6),
            CGPoint(x:x - w * 0.5, y:y + h * 0.5), CGPoint(x:x + h * 0.5, y:y - w * 0.6),
        ]
        self.strokeLine(linePoints)
    }

}