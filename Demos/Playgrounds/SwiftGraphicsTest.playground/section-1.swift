// Playground - noun: a place where people can play

import SwiftGraphics 

let context = CGContextRef.bitmapContext(CGSize(w:512, h:512))

context.withColor(NSColor.redColor()) {
//    context.fillCircle(center:CGPoint(x:256, y:256), radius:128)


    var path = CGPathCreateMutable()
    path.move(CGPoint(x:0, y:0))
    path.addLine(CGPoint(x:100, y:0), relative:true)
    path.addLine(CGPoint(x:0, y:100), relative:true)
    path.addLine(CGPoint(x:-100, y:0), relative:true)
    path.addLine(CGPoint(x:0, y:-100), relative:true)

    CGContextAddPath(context, path)
    CGContextStrokePath(context)
}








context.nsimage

