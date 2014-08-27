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
    var XMLDocument : NSXMLDocument?
                                                      
    override init() {
        super.init()
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
    }

    override func makeWindowControllers() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateInitialController() as NSWindowController
        self.addWindowController(windowController)  
        windowController.representedObject = self.XMLDocument
    }

    override func readFromData(data: NSData?, ofType typeName: String?, error outError: NSErrorPointer) -> Bool {
        

        XMLDocument = NSXMLDocument(data:data!, options:0, error:nil)



//        let pathElements = XMLDocument.nodesForXPath("//path", error:nil)!
//        if pathElements.count == 0 {
//            outError.memory = NSError.errorWithDomain(NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
//            return false
//        }
//        let pathElement = pathElements[0] as? NSXMLElement
//        let path = pathElement!.attributeForName("d")!.stringValue
//        let atoms = parsePath(path)
//        let commands = parseAtoms(atoms)
////        println(atomsToString(outputPath(commands)))
//        self.bezierPath = renderCommands(commands)        
//        if self.windowControllers.count > 0 {
//            if let mainWindowController = self.windowControllers[0] as? NSWindowController {
//                mainWindowController.representedObject = bezierPath
//            }
//        }
        return true
    }
}

