//
//  Utilities.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 8/24/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import CoreGraphics

// MARK: Math

infix operator ** { associativity none precedence 160 }

public func ** (lhs:Double, rhs:Double) -> Double {
    return pow(lhs, rhs)
}

public func ** (lhs:CGFloat, rhs:CGFloat) -> CGFloat {
    return pow(lhs, rhs)
}

// MARK: Basics

public func clamp <T:Comparable> (value:T, lower:T, upper:T) -> T {
    return max(min(value, upper), lower)
}

// MARK: lerp

public func lerp(lower:Double, upper:Double, factor:Double) -> Double {
    return (1.0 - factor) * lower + factor * upper
}

public func lerp(lower:CGPoint, upper:CGPoint, factor:CGFloat) -> CGPoint {
    return (1.0 - factor) * lower + factor * upper
}

public func lerp(lower:CGSize, upper:CGSize, factor:CGFloat) -> CGSize {
    return (1.0 - factor) * lower + factor * upper
}

public func lerp(lower:CGRect, upper:CGRect, factor:CGFloat) -> CGRect {
    return CGRect(
        origin:lerp(lower.origin, upper.origin, factor),
        size:lerp(lower.size, upper.size, factor)
        )
}

// MARK: Degrees/Radians

public func DegreesToRadians(v:CGFloat) -> CGFloat {
    return v * CGFloat(M_PI) / 180
}

public func RadiansToDegrees(v:CGFloat) -> CGFloat {
    return v * 180 / CGFloat(M_PI)
}

public func DegreesToRadians(v:Double) -> Double {
    return v * M_PI / 180
}

public func RadiansToDegrees(v:Double) -> Double {
    return v * 180 / M_PI
}

