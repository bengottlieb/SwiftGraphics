//
//  EditorView.swift
//  SwiftGraphicsDemo
//
//  Created by Jonathan Wight on 8/24/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Cocoa

import SwiftGraphics

protocol Editor {
    var handles:[CGPoint] { get }
    var guides:[CGPoint] { get }
}

class BezierEditor : Editor {
    var curve:BezierCurve = BezierCurve(start:CGPoint(x:0,y:0), control1:CGPoint(x:50,y:50), end:CGPoint(x:100,y:0))
    var handles:[CGPoint] { get { return self.curve.points } }
    var guides:[CGPoint] { get { return [] } }
}

class EditorView: NSView {

    var editor : Editor = BezierEditor()
    
    var activeHandle : Int?

    override init(frame frameRect: NSRect) {
        super.init(frame:frame)
    }

    required init(coder: NSCoder) {
        super.init(coder:coder)
        
//        NSPanGestureRecognizer
//        
//        self.addGestureRecognizer(<#gestureRecognizer: NSGestureRecognizer#>)
    }


    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        let context = NSGraphicsContext.currentContext().CGContext

        for p in self.editor.handles {
            context.withColor(NSColor.redColor()) {
                context.strokeCross(CGRect(center:p, size:CGSize(w:5, h:5)))
            }
        }

    }
    
//    override func mouseDown(theEvent: NSEvent!) {
//        let location = self.convertPoint(theEvent.locationInWindow, fromView:nil)
//        if let index = handleHit(location) {
//            activeHandle = index
//            self.needsDisplay = true
//        }
//    }

//    override func mouseDragged(theEvent: NSEvent!) {
//        if let activeHandle = activeHandle {
//            let location = self.convertPoint(theEvent.locationInWindow, fromView:nil)
//            self.editor.handles[activeHandle] = location
//            self.needsDisplay = true
//        }
//    }

//    override func mouseUp(theEvent: NSEvent!) {
//        self.activeHandle = nil
//        self.needsDisplay = true
//    }

//    func handleHit(point:CGPoint) -> Int? {
//        for (index, handle) in enumerate(handles) {
//            let R = CGFloat(10.0)
//            let handleRect = CGRect(x:handle.position.x - R, y:handle.position.y - R, width:R * 2, height:R * 2)
//            if handleRect.contains(point) {
//                return index
//            }
//        }
//        return nil
//    }

    
}
