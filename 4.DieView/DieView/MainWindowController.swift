//
//  MainWindowController.swift
//  DieView
//
//  Created by fancymax on 15/8/6.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    var configurationWindowController: ConfigurationWindowController?

    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func showDieConfiguration(sender: AnyObject?){
        if let window = window, let dieView = window.firstResponder as? DieView{
            let windowController = ConfigurationWindowController()
            windowController.color = dieView.color
            
            window.beginSheet(windowController.window!, completionHandler: {
                response in
                if response == NSModalResponseOK{
                    dieView.color = self.configurationWindowController!.color
                }
                //???
                self.configurationWindowController = nil
            })
            self.configurationWindowController = windowController
        }
    }
    
}
