// Playground - noun: a place where people can play

import SwiftGraphics 

typealias Transform = CGAffineTransform

var t = Transform(sx:100, sy:100)

t.scale(100,100)

var p = CGPoint(x:1,y:1)

p * t

t.values

