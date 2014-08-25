//
//  ArcView.swift
//  ArcTest
//
//  Created by Jonathan Wight on 8/23/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Cocoa

import SwiftGraphics

class ArcView: NSView {

    var arc : Arc!
    var handles : [Handle]!
    var activeHandle : Int?

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        let context = NSGraphicsContext.currentContext().CGContext

        for (index, handle) in enumerate(handles) {
            var color = NSColor.blackColor()
            if activeHandle == index {
                color = NSColor.redColor()
            }
            
            context.withColor(color) {
                context.fillCircle(center:handle.position, radius:3)
            }
        }

        let P0 = handles[0].position
        let P1 = handles[1].position
        let midPoint = (P0 + P1) * 0.5
        let radius = max(arc.rx, arc.ry)
        let center = arc.center
        
        context.withColor(NSColor.grayColor()) {
            context.strokeLine(P0, P1)
            context.fillCircle(center:midPoint, radius:2)
            context.strokeLine(center, midPoint)
            context.fillCircle(center:center, radius:2)
        }
        
        context.withColor(NSColor.blackColor()) {
            context.strokeEllipseInRect(CGRect(center:center, size:CGSize(width:radius * 2, height:radius * 2)))
        }
    }

    override func mouseDown(theEvent: NSEvent!) {
        let location = self.convertPoint(theEvent.locationInWindow, fromView:nil)
        if let index = handleHit(location) {
            activeHandle = index
            self.needsDisplay = true
        }
    }

    override func mouseDragged(theEvent: NSEvent!) {
        if let activeHandle = activeHandle {
            let location = self.convertPoint(theEvent.locationInWindow, fromView:nil)
            self.handles[activeHandle].position = location
            self.needsDisplay = true
        }
    }
    
    override func mouseUp(theEvent: NSEvent!) {
        self.activeHandle = nil
        self.needsDisplay = true
    }

    func handleHit(point:CGPoint) -> Int? {
        for (index, handle) in enumerate(handles) {
            let R = CGFloat(10.0)
            let handleRect = CGRect(x:handle.position.x - R, y:handle.position.y - R, width:R * 2, height:R * 2)
            if handleRect.contains(point) {
                return index
            }
        }
        return nil
    }
    
}
