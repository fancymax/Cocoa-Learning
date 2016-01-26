//
//  ImageViewController.swift
//  ViewController
//
//  Created by fancymax on 15/8/19.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Cocoa

class ImageViewController: NSViewController,ImageRepresentable {
    
    var image:NSImage?
    
    override var nibName:String?{
        return "ImageViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
