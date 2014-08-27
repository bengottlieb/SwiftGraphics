//
//  ViewController.swift
//  ArcTest
//
//  Created by Jonathan Wight on 8/23/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var arcView : ArcView!

    dynamic var x0:CGFloat = 100 { didSet { self.recomputeArc() } }
    dynamic var y0:CGFloat = 100 { didSet { self.recomputeArc() } }
    dynamic var rx:CGFloat = 50 { didSet { self.recomputeArc() } }
    dynamic var ry:CGFloat = 50 { didSet { self.recomputeArc() } }
    dynamic var angle:CGFloat = 0 { didSet { self.recomputeArc() } }
    dynamic var largeArcFlag:Bool = true { didSet { self.recomputeArc() } }
    dynamic var sweepFlag:Bool = true { didSet { self.recomputeArc() } }
    dynamic var x:CGFloat = 120 { didSet { self.recomputeArc() } }
    dynamic var y:CGFloat = 120 { didSet { self.recomputeArc() } }

    var SVGArc:SVGArcParameters? { didSet { self.arcView.SVGArc = self.SVGArc } }
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recomputeArc()
    }

    func recomputeArc() {
    
        self.SVGArc = SVGArcParameters(x0:x0, y0:y0, rx:rx, ry:ry, angle:angle, largeArcFlag:largeArcFlag, sweepFlag:sweepFlag, x:x, y:y)
    }
}

