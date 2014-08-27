//
//  Document.swift
//  SwiftSVGTest
//
//  Created by Jonathan Wight on 8/27/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Cocoa
import SwiftGraphics 

var representedObjectKey : Selector = "representedObject"

extension NSWindowController {

    var representedObject:AnyObject? {
        get {
            return objc_getAssociatedObject(self, &representedObjectKey)
        }
        set {
            objc_setAssociatedObject(self, &representedObjectKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
            self.contentViewController.representedObject = newValue
        }
    }
}

class Document: NSDocument {
               
    var bezierPath : NSBezierPath?
                                                      
    override init() {
        super.init()
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
    }

//    override class func autosavesInPlace() -> Bool {
//        return true
//    }

    override func makeWindowControllers() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateInitialController() as NSWindowController
        self.addWindowController(windowController)  
        windowController.representedObject = self.bezierPath
        
    }

    override func readFromData(data: NSData?, ofType typeName: String?, error outError: NSErrorPointer) -> Bool {
        //outError.memory = NSError.errorWithDomain(NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        
        let document = NSXMLDocument(data:data!, options:0, error:nil)
        
        let pathElements = document.nodesForXPath("//path", error:nil)!
        let pathElement = pathElements[0] as? NSXMLElement
        let path = pathElement!.attributeForName("d")!.stringValue
        let atoms = parsePath(path)
        let commands = parseAtoms(atoms)
//        println(atomsToString(outputPath(commands)))
        self.bezierPath = renderCommands(commands)        
        if self.windowControllers.count > 0 {
            if let mainWindowController = self.windowControllers[0] as? NSWindowController {
            
                mainWindowController.representedObject = bezierPath
            }
        }
        return true
    }
}

// #############################################################################

enum Atom {
    case Command(Character)
    case Number(CGFloat)
    case End // TODO change to NOP

    var isNumber : Bool {
        get {
            switch self {
                case .Command:
                    return false
                case .Number:
                    return true
                case .End:
                    return false
            }
        }
    }

    var value : CGFloat! {
        get {
            switch self {
                case .Command:
                    return nil
                case .Number(let value):
                    return value
                case .End:
                    return nil
            }
        }
    }
}

func parsePath(path:String) -> [Atom] {

    let scanner = NSScanner(string: path)
    // TODO: Use real whitespace
    scanner.charactersToBeSkipped = NSCharacterSet(charactersInString:" \n,")

    let set = NSCharacterSet(charactersInString:"MmZzLlHhVvCcSsQqTtAa")

    var atoms : [Atom] = []

    while scanner.atEnd == false {
        var s : NSString?
        if scanner.scanCharactersFromSet(set, intoString:&s) {
            let c = Character(s!)
            atoms.append(.Command(c))
        }

        var d : Double = 0.0
        if scanner.scanDouble(&d) {
            atoms.append(.Number(CGFloat(d)))
            }
        }

    atoms.append(.End)

    return atoms
    }

// #############################################################################

enum Command {
    case MoveTo(relative:Bool, xy:CGPoint)
    case ClosePath
    case LineTo(relative:Bool, xy:CGPoint)
    case HorizontalLineTo(relative:Bool, x:CGFloat)
    case VerticalLineTo(relative:Bool, y:CGFloat)
    case BezierCurveTo(relative:Bool, curve:BezierCurve)
//    case ShorthandQuadraticBezierCurveTo
    case EllipticalArc(relative:Bool, rxy:CGPoint, xrotation:CGFloat, largeArcFlag:Bool, sweepFlag:Bool, xy:CGPoint)
}

// #############################################################################

extension Character {
    var isLowercase : Bool { get { return contains("abcdefghijklmnopqrstuvwyxz", self) } } 
}

func parseAtoms(atoms:[Atom]) -> [Command] {

    var commands : [Command] = []

    var index = 0
    while index < atoms.count {
        let atom = atoms[index++]
        switch atom {
            case .Command(let c):
            
                let relative = c.isLowercase
            
                switch c {
                    case "M", "m":
                        while (atoms[index].isNumber) {
                            let x = atoms[index++].value
                            let y = atoms[index++].value
                            let coord = CGPoint(x:x, y:y)
                            let command = Command.MoveTo(relative:relative, xy:coord)
                            commands.append(command)
                        }
                    case "Z", "z":
                        let command = Command.ClosePath
                        commands.append(command)
                    case "L", "l":
                        while (atoms[index].isNumber) {
                            let x = atoms[index++].value
                            let y = atoms[index++].value
                            let coord = CGPoint(x:x, y:y)
                            let command = Command.LineTo(relative:relative, xy:coord)
                            commands.append(command)
                        }
                    case "H", "h":
                        while (atoms[index].isNumber) {
                            let x = atoms[index++].value
                            let command = Command.HorizontalLineTo(relative:relative, x:x)
                            commands.append(command)
                        }
                    case "V", "v":
                        while (atoms[index].isNumber) {
                            let y = atoms[index++].value
                            let command = Command.VerticalLineTo(relative:relative, y:y)
                            commands.append(command)
                        }
                    case "C", "c":
                        while (atoms[index].isNumber) {
                            let xy1 = CGPoint(x:atoms[index++].value, y:atoms[index++].value)
                            let xy2 = CGPoint(x:atoms[index++].value, y:atoms[index++].value)
                            let xy = CGPoint(x:atoms[index++].value, y:atoms[index++].value)
                            let curve = BezierCurve(control1:xy1, control2:xy2, end:xy)
                            let command = Command.BezierCurveTo(relative:relative, curve:curve)
                            commands.append(command)
                        }
                    case "S", "s":
                        while (atoms[index].isNumber) {
                            let xy1 = CGPoint(x:atoms[index++].value, y:atoms[index++].value)
                            let xy = CGPoint(x:atoms[index++].value, y:atoms[index++].value)
                            let curve = BezierCurve(control1:xy1, end:xy)
                            let command = Command.BezierCurveTo(relative:relative, curve:curve)
                            commands.append(command)
                        }
                    case "Q", "q":
                        assert(false)
                    case "T", "T":
                        assert(false)
                    case "A", "a":
                        while (atoms[index].isNumber) {
                            let rxy = CGPoint(x:atoms[index++].value, y:atoms[index++].value)
                            let xrotation = atoms[index++].value
                            let largeArcFlag = atoms[index++].value
                            let sweepflag = atoms[index++].value
                            let xy = CGPoint(x:atoms[index++].value, y:atoms[index++].value)
                            
                            let command = Command.EllipticalArc(relative:relative, rxy:rxy, xrotation: xrotation, largeArcFlag:largeArcFlag != 0.0, sweepFlag:sweepflag != 0.0, xy:xy)
                            commands.append(command)
                        }
                    default:
                        println("Unhandled command \(c)")
                        assert(false)
                }
            case .Number(let value):
                println("Unprocessed number \(value)")
            case .End:
                break
            }
        }

    return commands
    }

func atomsToString(atoms:[Atom]) -> String {
    var result : String = ""
    for atom in atoms {
        switch atom {
            case .Command(let c):
                result += "\(c) "
            case .Number(let d):
                result += "\(d) "
            default:
                break
        }
    }
    return result
}

// #############################################################################

func outputPath(commands : [Command]) -> [Atom]! {

    var atoms : [Atom] = []

    for command in commands {
        switch command {
            case .MoveTo(let relative, let xy):
                atoms += [
                    .Command(!relative ? "M" : "m"),
                    .Number(xy.x), .Number(xy.y)
                ]
            case .ClosePath:
                atoms += [
                    .Command("Z")
                ]
            case .LineTo(let relative, let xy):
                atoms += [
                    .Command(!relative ? "L" : "l"),
                    .Number(xy.x), .Number(xy.y)
                ]
            case .HorizontalLineTo(let relative, let x):
                atoms += [
                    .Command(!relative ? "H" : "h"),
                    .Number(x)
                ]
            case .VerticalLineTo(let relative, let y):
                atoms += [
                    .Command(!relative ? "V" : "v"),
                    .Number(y)
                ]
            case .BezierCurveTo(let relative, let curve):
                switch curve.order {
                    case .Quadratic:
                        atoms += [
                            .Command(!relative ? "S" : "s"),
                            .Number(curve.controls[0].x), .Number(curve.controls[0].y),
                            .Number(curve.end.x), .Number(curve.end.y),
                        ]
                    case .Cubic:
                        atoms += [
                            .Command(!relative ? "C" : "c"),
                            .Number(curve.controls[0].x), .Number(curve.controls[0].y),
                            .Number(curve.controls[1].x), .Number(curve.controls[1].y),
                            .Number(curve.end.x), .Number(curve.end.y),
                        ]
                    default:
                        return nil
                }
            default:
                println("Nope")
        }
    }
    return atoms
}


func renderCommands(commands : [Command]) -> NSBezierPath {
    var bezier = NSBezierPath()
    
    var controlPoints: [CGPoint] = []
    
    for command in commands {
        switch command {
            case .MoveTo(let relative, let xy):
                var p : CGPoint!
                if relative {
                    p = bezier.currentPoint + xy
                }
                else {
                    p = xy
                }
                bezier.moveToPoint(p)
            case .ClosePath:
                bezier.closePath()
            case .LineTo(let relative, let xy):
                var p : CGPoint!
                if relative {
                    p = bezier.currentPoint + xy
                }
                else {
                    p = xy
                }
                bezier.lineToPoint(p)
            case .HorizontalLineTo(let relative, let x):
                var p = bezier.currentPoint
                if relative {
                    p.x += x
                }
                else {
                    p.x = x
                }
                bezier.lineToPoint(p)
            case .VerticalLineTo(let relative, let y):
                var p = bezier.currentPoint
                if relative {
                    p.y += y
                }
                else {
                    p.y = y
                }
                bezier.lineToPoint(p)
            case .BezierCurveTo(let relative, let curve):
//                assert(relative == false)
                switch curve.order {
                    case .Quadratic:
                        var curve = curve
                        curve.start = bezier.currentPoint
                        controlPoints += curve.points
                        curve = curve.increasedOrder()
                        bezier.curveToPoint(curve.end, controlPoint1:curve.controls[0], controlPoint2:curve.controls[1])
                        controlPoints += curve.points
                    case .Cubic:
                        bezier.curveToPoint(curve.end, controlPoint1:curve.controls[0], controlPoint2:curve.controls[1])
                        var curve = curve
                        curve.start = bezier.currentPoint
                        controlPoints += curve.points
                    default:
                        println("Error: Cannot render arbitrary n-order bezier curves.")
                }
            case .EllipticalArc(let relative, let rxy, let xrotation, let largeArcFlag, let sweepFlag, let xy):
                println("Not EllipticalArc \(command)")
                
                
//                bezier.appendBezierPathWithArcWithCenter(<#center: NSPoint#>, radius: <#CGFloat#>, startAngle: <#CGFloat#>, endAngle: <#CGFloat#>, clockwise: <#Bool#>)
            
            default:
                println("Not handled \(command)")
                assert(false)
        }
    }
    
    for c in controlPoints {
        let rect = CGRect(x:c.x - 2.5, y:c.y - 2.5, width:5, height:5)
        bezier.appendBezierPathWithOvalInRect(rect)
    }
    return bezier
}

// #############################################################################

//var path = "M 100 100 L 300 100 L 200 300 z"
////var path = "M100,200 C100,100 250,100 250,200 S400,300 400,200"
////var path = "M600,800 C625,700 725,700 750,800 S875,900 900,800"
////var path = "M0,0 H100 V100 H0 V0"
////var path = "M0,0 h100 v100 h-100 v-100"
//
////let path = "M600,350 l 50,-25"
////+ "a25,25 -30 0,1 50,-25 l 50,-25"
////+ "a25,50 -30 0,1 50,-25 l 50,-25"
////+ "a25,75 -30 0,1 50,-25 l 50,-25" 
////+ "a25,100 -30 0,1 50,-25 l 50,-25"
//
//let atoms = parsePath(path)
//let commands = parseAtoms(atoms)
//
////atomsToString(outputPath(commands))
// 
//
//let bezier = renderCommands(commands)
//
//
//
//
//
//
