//
//  Geometry.swift
//  QuadTree
//
//  Created by Jonathan Wight on 8/6/14.
//  Copyright (c) 2014 schwa. All rights reserved.
//

import CoreGraphics

// TODO: This is a little bit silly. Probably won't live long.
public struct Circle {
    var origin:CGPoint
    var radius:CGFloat
    
    var rect:CGRect { get { return CGRect(x:origin.x - radius, y:origin.x - radius, width:radius * 2, height:radius * 2) } }
}