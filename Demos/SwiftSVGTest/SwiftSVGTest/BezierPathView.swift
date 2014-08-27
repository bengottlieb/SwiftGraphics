//
//  BezierPathView.swift
//  SwiftSVGTest
//
//  Created by Jonathan Wight on 8/27/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Cocoa

import SwiftGraphics

class BezierPathView: NSView {

    var document : SVGDocument!

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        let context = NSGraphicsContext.currentContext().CGContext
        if let document = document {
            context.draw(document)
        }
    }
}
