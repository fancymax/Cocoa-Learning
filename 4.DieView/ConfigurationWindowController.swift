//
//  ConfigurationWindowController.swift
//  DieView
//
//  Created by fancymax on 15/8/7.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Cocoa

class ConfigurationWindowController: NSWindowController {

    dynamic var color: NSColor = NSColor.whiteColor()
    
    override var windowNibName: String{
        return "ConfigurationWindowController"
    }
    
    @IBAction func okayButtonClicked(button:NSButton){
        window?.endEditingFor(nil)
        dismissWithModalResponse(NSModalResponseOK)
        print("OK clicked")
    }
    
    @IBAction func cancelButtonClicked(button:NSButton){
        dismissWithModalResponse(NSModalResponseCancel)
        print("Cancel clicked")
    }
    
    func dismissWithModalResponse(response:NSModalResponse)
    {
        window!.sheetParent!.endSheet(window!,returnCode: response)
    }
}
