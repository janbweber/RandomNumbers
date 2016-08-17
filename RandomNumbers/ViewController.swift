//
//  ViewController.swift
//  RandomNumbers
//
//  Created by Jan B Weber on 16.05.16.
//  Copyright © 2016 Hilbert Games. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // MARK: Properties

    @IBOutlet weak var lowerBoundTextField: NSTextField!
    @IBOutlet weak var upperBoundTextField: NSTextField!
    @IBOutlet weak var algorithmPopUp: NSPopUpButton!
    @IBOutlet weak var securitySlider: NSSlider!
    @IBOutlet weak var progBar: NSProgressIndicator!
    @IBOutlet weak var progIndicator: NSProgressIndicator!
    @IBOutlet weak var generateButton: NSButton!
    @IBOutlet weak var randNumberTextField: NSTextField!
    
    var randN: UInt32 = 0
    let MT19937: MersenneTwisterMT19937 = MersenneTwisterMT19937(seed: UInt32(NSDate().timeIntervalSince1970))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progIndicator.hidden = true
        lowerBoundTextField.stringValue = "0"
        upperBoundTextField.stringValue = "1000000"
        
        print("Ready")
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    private func generator(seed: Double) -> Double {
        return Double(10)
    }
    
    private func mersenne19937() -> UInt32 {
        return MT19937.extract_number()
    }
    
    // MARK: Actions
    @IBAction func generateRand(sender: NSButton) {
        progIndicator.startAnimation(NSNull)
        progIndicator.hidden = false
        for i in 0 ..< securitySlider.intValue * 10000 + 1000000 {
            randN = mersenne19937()
            progBar.incrementBy(100.0/Double(i))
        }
        progIndicator.hidden = true
        progIndicator.stopAnimation(NSNull)
        randNumberTextField.stringValue = String(randN)
    }
    


}

