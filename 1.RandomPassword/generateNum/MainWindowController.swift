//
//  MainWindowController.swift
//  generateNum
//
//  Created by fancymax on 15/7/24.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    override var windowNibName:String?{
        return "MainWindowController"
    }

    @IBOutlet weak var passField: NSTextField!
    
    @IBAction func generatePassWord(sender: AnyObject) {
        let string = generateRandomString(10)
        passField.stringValue = string
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}
