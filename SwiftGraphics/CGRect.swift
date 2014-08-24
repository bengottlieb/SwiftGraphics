//
//  CGRect.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 8/24/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import CoreGraphics

// MARK: CGRect

public extension CGRect {
    init(size:CGSize) {
        self.origin = CGPointZero
        self.size = size
    }
    
    init(width:CGFloat, height:CGFloat) {
        self.origin = CGPointZero
        self.size = CGSize(width:width, height:height)
    }

    init(P1:CGPoint, P2:CGPoint) {
        self.origin = CGPoint(x:min(P1.x, P2.x), y:min(P1.y, P2.y))
        self.size = CGSize(width:abs(P2.x - P1.x), height:abs(P2.y - P1.y))
    }

    init(center:CGPoint, size:CGSize) {
        self.origin = CGPoint(x:center.x - size.width * 0.5, y:center.y - size.height * 0.5)
        self.size = size
    }
}

public func * (lhs:CGRect, rhs:CGFloat) -> CGRect {
    return CGRect(origin:lhs.origin * rhs, size:lhs.size * rhs)
}

public func * (lhs:CGFloat, rhs:CGRect) -> CGRect {
    return CGRect(origin:lhs * rhs.origin, size:lhs * rhs.size)
}

public extension CGRect {    
    var isFinite : Bool { get { return CGRectIsNull(self) == false && CGRectIsInfinite(self) == false } }
    var mid : CGPoint { get { return CGPoint(x:self.midX, y:self.midY) } }
    
    static func UnionOfRects(rects:[CGRect]) -> CGRect {
        var result = CGRectZero
        for rect in rects {
            result = CGRectUnion(result, rect)
        }
        return result
    }
}

