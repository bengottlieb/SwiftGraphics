//
//  CGSize.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 8/24/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import CoreGraphics

// MARK: CGSize

public extension CGSize {
    init(width:CGFloat) {
        self.width = width
        self.height = 0
    }

    init(height:CGFloat) {
        self.width = 0
        self.height = height
    }
}

public func + (lhs:CGSize, rhs:CGSize) -> CGSize {
    return CGSize(width:lhs.width + rhs.width, height:lhs.height + rhs.height)
}

public func - (lhs:CGSize, rhs:CGSize) -> CGSize {
    return CGSize(width:lhs.width - rhs.width, height:lhs.height - rhs.height)
}

public func * (lhs:CGSize, rhs:CGFloat) -> CGSize {
    return CGSize(width:lhs.width * rhs, height:lhs.height * rhs)
}

public func * (lhs:CGFloat, rhs:CGSize) -> CGSize {
    return CGSize(width:lhs * rhs.width, height:lhs * rhs.height)
}

public func / (lhs:CGSize, rhs:CGFloat) -> CGSize {
    return CGSize(width:lhs.width / rhs, height:lhs.height / rhs)
}

public func / (lhs:CGFloat, rhs:CGSize) -> CGSize {
    return CGSize(width:lhs / rhs.width, height:lhs / rhs.height)
}

public func += (inout lhs:CGSize, rhs:CGSize) {
    lhs = lhs + rhs
}

public func -= (inout lhs:CGSize, rhs:CGSize) {
    lhs = lhs - rhs
}

public func *= (inout lhs:CGSize, rhs:CGFloat) {
    lhs = lhs * rhs
}

public func /= (inout lhs:CGSize, rhs:CGFloat) {
    lhs = lhs / rhs
}

public extension CGSize {
    var aspectRatio : CGFloat { get { return width / height } }
    var isSquare : Bool { get { return width == height } }
    var isPortrait : Bool { get { return height > width } }
    var isLandscape : Bool { get { return width > height } }
}

