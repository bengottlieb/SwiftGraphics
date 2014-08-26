//
//  EditorView.swift
//  SwiftGraphicsDemo
//
//  Created by Jonathan Wight on 8/24/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Cocoa

import SwiftGraphics

struct Handle {
    var position : CGPoint
    
//    init(position:CGPoint) {
//        self.position = position
//    }
}

extension CGContextRef {

    func stroke(curve:BezierCurve) {
        switch curve.order {
            case .Quadratic:
                if let start = curve.start {
                    CGContextMoveToPoint(self, start.x, start.y)
                    }
                CGContextAddQuadCurveToPoint(self, curve.controls[0].x, curve.controls[0].y, curve.end.x, curve.end.y)              
                CGContextStrokePath(self)
            case .Cubic:
                if let start = curve.start {
                    CGContextMoveToPoint(self, start.x, start.y)
                    }
                CGContextAddCurveToPoint(self, curve.controls[0].x, curve.controls[0].y, curve.controls[1].x, curve.controls[1].y, curve.end.x, curve.end.y)              
                CGContextStrokePath(self)
            case .OrderN(let order):
                assert(false)
        }
    }
}

protocol Editor {
    var handles:[Handle] { get }
    var guides:[Handle] { get }
    func setHandlePosition(handle:Int, position:CGPoint);
    func draw(context:CGContextRef);
}

class BezierEditor : Editor {
    var curve:BezierCurve
    var handles:[Handle] = []
    var guides:[Handle] = []

    init() {
        self.curve = BezierCurve(start:CGPoint(x:100,y:100), control1:CGPoint(x:150,y:150), end:CGPoint(x:200,y:100))
        self.handles = self.curve.points.map {
            (p:CGPoint) -> Handle in
            return Handle(position:p)
            }    
        self._update()
    }
    
    func setHandlePosition(handle:Int, position:CGPoint) {
        self.handles[handle].position = position
        self._update()
    }
    
    func _update() {
        // Make a new curve from the points of the handles...
        let points = self.handles.map() {
            (h:Handle) -> CGPoint in
            return h.position
            }
        self.curve = BezierCurve(points:points)

        // Make a cubic and turn its points into guides...
        let cubicCurve = self.curve.increasedOrder()        
        self.guides = cubicCurve.controls.map {
            (p:CGPoint) -> Handle in
            return Handle(position:p)
        }
    }
    
    func draw(context:CGContextRef) {
        for p in self.handles {
            context.withColor(NSColor.redColor()) {
                context.strokeCross(CGRect(center:p.position, size:CGSize(w:6, h:6)))
            }
        }
        for p in self.guides {
            context.withColor(NSColor.blueColor()) {
                context.strokeSaltire(CGRect(center:p.position, size:CGSize(w:3, h:3)))
            }
        }
        
        context.stroke(self.curve)
    }
}

class EditorView: NSView {

    var editor : Editor = BezierEditor()
    
    var activeHandle : Int?

    override init(frame frameRect: NSRect) {
        super.init(frame:frame)
    }

    required init(coder: NSCoder) {
        super.init(coder:coder)
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        let context = NSGraphicsContext.currentContext().CGContext
        self.editor.draw(context)
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
            self.editor.setHandlePosition(activeHandle, position:location)
            self.needsDisplay = true
        }
    }

    override func mouseUp(theEvent: NSEvent!) {
        self.activeHandle = nil
        self.needsDisplay = true
    }

    func handleHit(point:CGPoint) -> Int? {
        for (index, handle) in enumerate(self.editor.handles) {
            let R = CGFloat(10.0)
            let handleRect = CGRect(x:handle.position.x - R, y:handle.position.y - R, width:R * 2, height:R * 2)
            if handleRect.contains(point) {
                return index
            }
        }
        return nil
    }

}
