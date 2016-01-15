//
//  NSString+Drawing.swift
//  DieView
//
//  Created by fancymax on 15/8/6.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Cocoa

extension NSString{
    func drawCenterInRect(rect:NSRect, attributes:[String: AnyObject!]){
        let stringSize = sizeWithAttributes(attributes)
        let point = NSPoint(x: rect.origin.x + (rect.width - stringSize.width)/2, y: rect.origin.y + (rect.height - stringSize.height)/2)
        drawAtPoint(point, withAttributes: attributes)
    }
}
