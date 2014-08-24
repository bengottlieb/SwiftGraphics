//
//  BezierArc.swift
//  SwiftGraphics
//
//  Created by Jonathan Wight on 8/24/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Foundation

public struct BezierCurve {

    enum Order {
        case Quadratic
        case Cubic
        case OrderN(Int)
    }

    var start : CGPoint?
    var controls : [CGPoint]
    var end : CGPoint

    init(controls:[CGPoint], end:CGPoint) {
        self.controls = controls
        self.end = end
    }

    init(control1:CGPoint, end:CGPoint) {
        self.controls = [control1]
        self.end = end
    }

    init(control1:CGPoint, control2:CGPoint, end:CGPoint) {
        self.controls = [control1, control2]
        self.end = end
    }

    init(start:CGPoint, controls:[CGPoint], end:CGPoint) {
        self.start = start
        self.controls = controls
        self.end = end
    }

    init(start:CGPoint, control1:CGPoint, end:CGPoint) {
        self.start = start
        self.controls = [control1]
        self.end = end
    }

    init(start:CGPoint, control1:CGPoint, control2:CGPoint, end:CGPoint) {
        self.start = start
        self.controls = [control1, control2]
        self.end = end
    }

    var order : Order {
        get {
            switch self.controls.count + 2 {
                case 3:
                    return .Quadratic
                case 4:
                    return .Cubic
                default:
                    return .OrderN(self.controls.count + 2)
            }       
        }
    }
    var points : [CGPoint] { get { return [self.start!] + self.controls + [self.end] } }
}

extension BezierCurve : Printable {
    public var description: String { get {
        let controlsString = ", ".join(controls.map() {
            (c:CGPoint) -> String in
            return "(\(c.x), \(c.y))"
        })
        return "BezierCurve(start:\(start?.description), controls:\(controlsString), end:\(end.description))"
    } }
}

public extension BezierCurve {
    func increasedOrder() -> BezierCurve {
//        assert(self.order == Order.Quadratic)
        assert(self.points.count == 1)
    
        let CP1 = points[0] + ((2.0 / 3.0) * (points[1] - points[0]))
        let CP2 = points[2] + ((2.0 / 3.0) * (points[1] - points[2]))
        return BezierCurve(start:start!, controls:[CP1, CP2], end:end)
    }
}
