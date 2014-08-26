//
//  ViewController.swift
//  ArcTest
//
//  Created by Jonathan Wight on 8/23/14.
//  Copyright (c) 2014 schwa.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var arc : TestArc = TestArc()
        
    @IBOutlet var arcView : ArcView!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arcView.arc = self.arc
        self.arcView.handles = self.arc.handles

        // Do any additional setup after loading the view.
                                    
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
                                    
    }


}

