//
//  ViewController.swift
//  SwiftSVGTest
//
//  Created by Jonathan Wight on 8/27/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var bezierPathView : BezierPathView!  
                                                     
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: AnyObject? {
        didSet {
            let bezierPath = self.representedObject as NSBezierPath
            self.bezierPathView.bezierPath = bezierPath
        }                                    
    }
}

