//
//  Path.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 8/27/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Foundation

public struct Path {
    enum Element {
        case Move(CGPoint)
        case AddLine(CGPoint)
        case AddCurve(BezierCurve)
        case Close
    }
    
    var elements:[Element] = []
    
    var currentPoint : CGPoint = CGPointZero
    
    mutating func move(point:CGPoint) -> Path {
        currentPoint = point
        elements.append(.Move(point))
        return self
    }
    
    mutating func addLine(point:CGPoint) -> Path {
        currentPoint = point
        elements.append(.AddLine(point))
        return self
    }

    mutating func addCurve(curve:BezierCurve) -> Path {
        currentPoint = curve.end
        elements.append(.AddCurve(curve))
        return self
    }

    mutating func close() -> Path {
        elements.append(.Close)
        return self
    }
}
