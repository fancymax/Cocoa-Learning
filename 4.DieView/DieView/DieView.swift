//
//  DieView.swift
//  DieView
//
//  Created by fancymax on 15/8/6.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Cocoa

class DieView:NSView {
    var intValue:Int? = 2{
        didSet{
            if(oldValue != intValue)
            {
                needsDisplay = true
                Swift.print("needsDisplay")
            }
        }
    }
    
    var pressed:Bool = false{
        didSet{
            needsDisplay = true
        }
    }
    
    var color:NSColor = NSColor.whiteColor(){
        didSet{
            needsDisplay = true
        }
    }
    
    @IBAction func savePDF(sender: AnyObject!){
        let savePanel = NSSavePanel()
        savePanel.allowedFileTypes = ["pdf"]
        savePanel.beginSheetModalForWindow(window!, completionHandler: {
            [unowned savePanel] (result) in
            if result == NSModalResponseOK{
                let data = self.dataWithPDFInsideRect(self.bounds)
                do{
                    try data.writeToURL(savePanel.URL!, options: NSDataWritingOptions.AtomicWrite)
                }
                catch let error as NSError{
                    let alert = NSAlert(error: error)
                    alert.runModal()
                }
            }
        })
    }
    
    override func drawRect(dirtyRect: NSRect) {
        let backGroundColor = NSColor.lightGrayColor()
        backGroundColor.set()
        NSBezierPath.fillRect(bounds)
        
        drawDieWithSize(bounds.size)
    }
    
    override func mouseDown(theEvent: NSEvent) {
        Swift.print("mouseDown")
        if(!isPointInView(theEvent.locationInWindow))
        {
            return
        }
        pressed = true
    }
    
    override var acceptsFirstResponder:Bool{return true}
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    override func keyDown(theEvent: NSEvent) {
        interpretKeyEvents([theEvent])
        Swift.print("keyDown")
    }
    
    override func insertText(insertString: AnyObject) {
        Swift.print("insertText")
        let text = insertString as! String
        if let number = Int(text)
        {
            intValue = number
        }
    }
    
    override func insertTab(sender: AnyObject?) {
        Swift.print("insertTab")
        window?.selectNextKeyView(sender)
    }
    
    override func insertBacktab(sender: AnyObject?) {
        Swift.print("insertBackTab")
        window?.selectNextKeyView(sender)
    }
    
    override var focusRingMaskBounds:NSRect{
        return bounds
    }
    override func drawFocusRingMask() {
        NSBezierPath.fillRect(bounds)
    }
    
    private func isPointInView(point: CGPoint)->Bool
    {
        let dieFrame = metricsForSize(bounds.size).dieFrame
        let pointInView = convertPoint(point, fromView: nil)
        return dieFrame.contains(pointInView)
    }
    
    override func mouseUp(theEvent: NSEvent) {
        Swift.print("mouseUp clickCount = \(theEvent.clickCount)")
        if(!isPointInView(theEvent.locationInWindow))
        {
            return
        }
        if theEvent.clickCount == 2{
            randomize()
        }
        pressed = false
    }
    
    func randomize(){
        intValue = Int(arc4random_uniform(5)) + 1
    }
    
    func metricsForSize(size:CGSize) ->(edgeLength:CGFloat, dieFrame:CGRect){
        let edgeLength = min(size.height, size.width)
        let padding = edgeLength / 10
        let drawingBounds = CGRect(x: 0, y: 0, width: edgeLength, height: edgeLength)
        var dieFrame = drawingBounds.insetBy(dx: padding, dy: padding)
        if pressed{
            dieFrame = dieFrame.offsetBy(dx: 0, dy: -edgeLength/40)
        }
        return (edgeLength,dieFrame)
    }
    
    func drawDieWithSize(size:CGSize){
        let(edgeLength, dieFrame) = metricsForSize(size)
        
        //当前图形信息上下文 压入堆栈
        NSGraphicsContext.saveGraphicsState()
        let shadow = NSShadow()
        shadow.shadowOffset = NSSize(width: 0, height: -1)
        shadow.shadowBlurRadius = (pressed ? edgeLength/100 : edgeLength/20)
        shadow.set()
        
        let cornerRadius:CGFloat = edgeLength/5
        color.set()
        NSBezierPath(roundedRect: dieFrame, xRadius: cornerRadius, yRadius: cornerRadius).fill()
        
        NSGraphicsContext.restoreGraphicsState()
        let dotRadius = edgeLength/12
        let dotFrame = dieFrame.insetBy(dx: dotRadius*2.5, dy: dotRadius*2.5)
        NSColor.blackColor().set()
        
        func drawDot(u:CGFloat, v:CGFloat)
        {
            let dotOrigin = CGPoint(x: dotFrame.minX + dotFrame.width * u, y: dotFrame.minY + dotFrame.height * v)
            let dotRect = CGRect(origin: dotOrigin, size: CGSizeZero).insetBy(dx:-dotRadius, dy:-dotRadius)
            NSBezierPath(ovalInRect: dotRect).fill()
        }
        
        if (1...6).indexOf(intValue!) != nil
        {
            if [1,3,5].indexOf(intValue!) != nil
            {
                drawDot(0.5, v: 0.5)
            }
            if (2...6).indexOf(intValue!) != nil{
                drawDot(0, v: 1)
                drawDot(1, v: 0)
            }
            if (4...6).indexOf(intValue!) != nil{
                drawDot(1, v: 1)
                drawDot(0, v: 0)
            }
            if intValue! == 6{
                drawDot(0, v: 0.5)
                drawDot(1, v: 0.5)
            }
        }
        else
        {
            let paraStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
            let font = NSFont.systemFontOfSize(edgeLength * 0.5)
            let attrs = [
                NSForegroundColorAttributeName:NSColor.blackColor(),
                NSFontAttributeName:font,
                NSParagraphStyleAttributeName:paraStyle ]
            let string = "\(intValue!)" as NSString
            Swift.print(string)
            string.drawCenterInRect(dieFrame, attributes: attrs)
            
        }
        
    }
    
}
