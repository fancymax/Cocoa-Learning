//
//  MainWindowController.swift
//  RGBWell
//
//  Created by fancymax on 15/7/27.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    @IBOutlet weak var colorWell: NSColorWell!
    var redColor:CGFloat = CGFloat()
    var greenColor:CGFloat = CGFloat()
    var blueColor:CGFloat = CGFloat()
    
    @IBAction func setRed(sender: NSSlider) {
        redColor = CGFloat(sender.floatValue)
        print("redColor = \(redColor)")
        changeColorWell()
        
    }
    
    @IBAction func setGreen(sender: NSSlider) {
        greenColor = CGFloat(sender.floatValue)
        print("greenColor = \(greenColor)")
        changeColorWell()
    }
    
    @IBAction func setBlue(sender: NSSlider) {
        blueColor = CGFloat(sender.floatValue)
        print("blueColor = \(blueColor)")
        changeColorWell()
    }
    
    private func changeColorWell()
    {
        colorWell.color = NSColor(red: redColor, green: greenColor, blue: blueColor, alpha: CGFloat(1.0))
    }
    
}
