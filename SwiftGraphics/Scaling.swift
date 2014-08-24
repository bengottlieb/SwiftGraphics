//
//  Scaling.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 8/24/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import CoreGraphics

// MARK: Scaling and alignment.

public enum Scaling {
    case None
    case Proportionally
    case ToFit
}

public enum Alignment {
   case Center
   case Top
   case TopLeft
   case TopRight
   case Left
   case Bottom
   case BottomLeft
   case BottomRight
   case Right
}

public func ScaleAndAlignRectToRect(inner:CGRect, outer:CGRect, scaling:Scaling, align:Alignment) -> CGRect {
    var resultRect = CGRectZero

    switch scaling {
    case .ToFit:
        resultRect = outer
    case .Proportionally:
        var theScaleFactor = CGFloat(1.0)
        if (outer.size.width / inner.size.width < outer.size.height / inner.size.height) {
            theScaleFactor = outer.size.width / inner.size.width
        }
        else {
            theScaleFactor = outer.size.height / inner.size.height
        }
        resultRect.size = inner.size * theScaleFactor
    case .None:
        switch align {
            //
        case .Center:
            resultRect.origin.x = outer.origin.x + (outer.size.width - inner.size.width) * 0.5
            resultRect.origin.y = outer.origin.y + (outer.size.height - inner.size.height) * 0.5
        case .Top:
            resultRect.origin.x = outer.origin.x + (outer.size.width - inner.size.width) * 0.5
            resultRect.origin.y = outer.origin.y + outer.size.height - inner.size.height
        case .TopLeft:
            resultRect.origin.x = outer.origin.x
            resultRect.origin.y = outer.origin.y + outer.size.height - inner.size.height
        case .TopRight:
            resultRect.origin.x = outer.origin.x + outer.size.width - inner.size.width
            resultRect.origin.y = outer.origin.y + outer.size.height - inner.size.height
        case .Left:
            resultRect.origin.x = outer.origin.x
            resultRect.origin.y = outer.origin.y + (outer.size.height - inner.size.height) * 0.5
        case .Bottom:
            resultRect.origin.x = outer.origin.x + (outer.size.width - inner.size.width) * 0.5
            resultRect.origin.y = outer.origin.y
        case .BottomLeft:
            resultRect.origin.x = outer.origin.x
            resultRect.origin.y = outer.origin.y
        case .BottomRight:
            resultRect.origin.x = outer.origin.x + outer.size.width - inner.size.width
            resultRect.origin.y = outer.origin.y
        case .Right:
            resultRect.origin.x = outer.origin.x + outer.size.width - inner.size.width
            resultRect.origin.y = outer.origin.y + (outer.size.height - inner.size.height) * 0.5
        }
    }
    
    return resultRect
}
