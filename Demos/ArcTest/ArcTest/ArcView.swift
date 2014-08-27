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

    var SVGArc : SVGArcParameters! { didSet {
        self.handles = [
            Handle(position:CGPoint(x:SVGArc.x0, y:SVGArc.y0)),
            Handle(position:CGPoint(x:SVGArc.x, y:SVGArc.y)),
        ]
        self.arc = Arc.arcWithSVGDefinition(SVGArc)
        } }
    var arc : Arc! { didSet { self.needsDisplay = true } }
    var handles : [Handle]!
    var activeHandle : Int?

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        let context = NSGraphicsContext.currentContext().CGContext

        if let arc = self.arc {
            context.stroke(arc)
            }

        for (index, handle) in enumerate(handles) {
            var color = NSColor.blueColor()
            if activeHandle == index {
                color = NSColor.redColor()
            }
            
            context.withColor(color) {
                context.fillCircle(center:handle.position, radius:3)
            }
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
