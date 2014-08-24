//
//  Quadrant.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 8/24/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import CoreGraphics

// MARK: Quadrants

public enum Quadrant {
    case TopLeft
    case TopRight
    case BottomLeft
    case BottomRight
}

public extension Quadrant {
    static func fromPoint(point:CGPoint) -> Quadrant {
        if (point.y >= 0) {
            if (point.x >= 0) {
                return(.TopRight)
            }
            else {
                return(.TopLeft)
            }
        }
        else {
            if (point.x >= 0) {
                return(.BottomRight)
            }
            else {
                return(.BottomLeft)
            }
        }
    }

    static func fromPoint(point:CGPoint, origin:CGPoint) -> Quadrant {
        return Quadrant.fromPoint(point - origin)
    }

    static func fromPoint(point:CGPoint, rect:CGRect) -> Quadrant {
        return Quadrant.fromPoint(point - rect.mid)
    }

    func quadrantRectOfRect(rect:CGRect) -> CGRect {
        let size = CGSize(width:rect.size.width * 0.5, height:rect.size.height * 0.5)
        switch self {
        case .TopLeft:
            return CGRect(origin:CGPoint(x:rect.minX, y:rect.midY), size:size)
        case .TopRight:
            return CGRect(origin:CGPoint(x:rect.midX, y:rect.midY), size:size)
        case .BottomLeft:
            return CGRect(origin:CGPoint(x:rect.minX, y:rect.minY), size:size)
        case .BottomRight:
            return CGRect(origin:CGPoint(x:rect.midX, y:rect.minY), size:size)
        }
    }
}