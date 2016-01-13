//
//  AppDelegate.swift
//  generateNum
//
//  Created by fancymax on 15/7/24.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    var mainWindowController:MainWindowController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let mainController = MainWindowController()
        mainController.showWindow(self)
        self.mainWindowController = mainController
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

