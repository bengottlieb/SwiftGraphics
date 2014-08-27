//
//  ViewController.swift
//  SwiftSVGTest
//
//  Created by Jonathan Wight on 8/27/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    @IBOutlet var bezierPathView : BezierPathView!  
    @IBOutlet var webView : WebView!

    var XMLDocument : NSXMLDocument!
                                                     
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: AnyObject? {
        didSet {
            XMLDocument = self.representedObject as? NSXMLDocument

            var parser = SVGParser()
            parser.parseElement(XMLDocument.rootElement())

            let document = parser.document
            bezierPathView.document = document


//            self.bezierPathView.bezierPath = bezierPath
        }                                    
    }
}

