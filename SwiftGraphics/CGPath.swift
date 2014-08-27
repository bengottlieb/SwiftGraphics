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

//internal func MyApplier(info:UnsafeMutablePointer<Void>, element:UnsafePointer<CGPathElement>) -> Void {
//    println("Element")
//}
//
//
//extension CGPath {
//
//    func dump() {
//        CGPathApply(self, nil, MyApplier)
//    }
//}