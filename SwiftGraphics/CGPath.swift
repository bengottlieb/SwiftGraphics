//
//  CGPath.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 8/27/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import CoreGraphics

public extension CGMutablePath {

    var currentPoint : CGPoint { get { return CGPathGetCurrentPoint(self) } }

    func move(point:CGPoint) -> CGMutablePath {
        CGPathMoveToPoint(self, nil, point.x, point.y)
        return self
    }

    func move(point:CGPoint, relative:Bool) -> CGMutablePath {
        if relative {
            return self.move(point + currentPoint)
        }
        else {
            return self.move(point)
        }
    }
    
    func close() -> CGMutablePath {
        CGPathCloseSubpath(self)
        return self
    }

    func addLine(point:CGPoint) -> CGMutablePath {
        CGPathAddLineToPoint(self, nil, point.x, point.y)
        return self
    }

    func addLine(point:CGPoint, relative:Bool) -> CGMutablePath {
        if relative {
            return self.addLine(point + currentPoint)
        }
        else {
            return self.addLine(point)
        }
    }

    func addQuadCurveToPoint(end:CGPoint, control1:CGPoint) -> CGMutablePath {
        CGPathAddQuadCurveToPoint(self, nil, control1.x, control1.y, end.x, end.y)
        return self
    }

    func addQuadCurveToPoint(end:CGPoint, control1:CGPoint, relative:Bool) -> CGMutablePath {
        if relative {
            return addQuadCurveToPoint(end + currentPoint, control1:control1 + currentPoint)
        }
        else {
            return addQuadCurveToPoint(end, control1:control1)
        }
    }

    func addCubicCurveToPoint(end:CGPoint, control1:CGPoint, control2:CGPoint) -> CGMutablePath {
        CGPathAddCurveToPoint(self, nil, control1.x, control1.y, control2.x, control2.y, end.x, end.y)
        return self
    }

    func addCubicCurveToPoint(end:CGPoint, control1:CGPoint, control2:CGPoint, relative:Bool) -> CGMutablePath {
        if relative {
            return addCubicCurveToPoint(end + currentPoint, control1:control1 + currentPoint, control2:control2 + currentPoint)
        }
        else {
            return addCubicCurveToPoint(end, control1:control1, control2:control2)
        }
    }

    func addCurve(curve:BezierCurve, relative:Bool = false) -> CGMutablePath {
        switch curve.order {
            case .Quadratic:
                if let start = curve.start {
                    self.move(start)
                }
                return self.addQuadCurveToPoint(curve.end, control1:curve.controls[0], relative:relative)
            case .Cubic:
                if let start = curve.start {
                    self.move(start)
                }
                return self.addCubicCurveToPoint(curve.end, control1:curve.controls[0], control2:curve.controls[1], relative:relative)
            default:
                assert(false)
        }
        return self
    }
}

public extension CGPath {

    func dump() {
        CGPathApplyWithBlock(self) {
            (elementPtr:UnsafePointer<CGPathElement>) -> Void in
            let element : CGPathElement = elementPtr.memory

                switch element.type.value {
                    case kCGPathElementMoveToPoint.value:
                        println("kCGPathElementMoveToPoint")
                        let point = element.points.memory
                        println(point)
                    case kCGPathElementAddLineToPoint.value:
                        println("kCGPathElementAddLineToPoint")
                        let point = element.points.memory
                        println(point)
                    case kCGPathElementAddQuadCurveToPoint.value:
                        println("kCGPathElementAddQuadCurveToPoint")
                        let point = element.points.memory
                        println(point)
                        let point2 = element.points.advancedBy(1).memory
                        println(point2)
                    case kCGPathElementAddCurveToPoint.value:
                        println("kCGPathElementAddCurveToPoint")
                        let point = element.points.memory
                        println(point)
                        let point2 = element.points.advancedBy(1).memory
                        println(point2)
                        let point3 = element.points.advancedBy(2).memory
                        println(point3)
                    case kCGPathElementCloseSubpath.value:
                        println("kCGPathElementCloseSubpath")
                    default:
                        println("default")
                }


//struct CGPathElement {
//    var type: CGPathElementType
//    var points: UnsafeMutablePointer<CGPoint>
//}
//

            
            
            println("Element")
        }
    }
}