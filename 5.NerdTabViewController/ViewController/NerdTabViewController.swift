//
//  NerdTabViewController.swift
//  ViewController
//
//  Created by fancymax on 15/8/21.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Cocoa

@objc
protocol ImageRepresentable{
    var image:NSImage?{get}
}

class NerdTabViewController: NSViewController {
    
    var box = NSBox()
    var buttons = [NSButton]()
    
    func selectTabAtIndex(_ index:Int){
        assert((0..<childViewControllers.count).contains(index), "index out of range")
        for (i,button) in buttons.enumerated() {
            button.state = (index == i) ? NSOnState : NSOffState
        }
        let viewController = childViewControllers[index] 
        box.contentView = viewController.view
    }
    
    func selectTab(_ sender:NSButton){
        let index = sender.tag
        selectTabAtIndex(index)
    }
    
    override func loadView() {
        view = NSView()
        reset()
    }
    
    func reset()
    {
        view.subviews = []
        let buttonHeight: CGFloat = 28
        let buttonWidth: CGFloat = 28
        
        let viewControllers = childViewControllers 
        buttons = viewControllers.enumerated().map{
            (index,controller) -> NSButton in
            let button =  NSButton()
            button.setButtonType(.toggle)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.isBordered = false
            button.target = self
            button.action = #selector(NerdTabViewController.selectTab(_:))
            button.tag = index
            
            if let controller = controller as? ImageRepresentable{
                button.image = controller.image
            }
            else{
                button.title = controller.title!
            }
        
            button.addConstraints([NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: buttonWidth),
            NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: buttonHeight)])
            return button
        }
        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .horizontal
        stackView.spacing = 4
        for button in buttons {
            stackView.addView(button, in: .center)
        }
        
        box.translatesAutoresizingMaskIntoConstraints = false
        box.borderType = .noBorder
        box.boxType = .custom
        
        let separator = NSBox()
        separator.boxType = .separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        view.subviews = [stackView, separator,box]
        let views = ["stack":stackView,"separator":separator,"box":box]
        let metrics = ["buttonHeight":buttonHeight]
        
        func addVisualFormatConstraints(_ visualFormat:String){
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualFormat,
                options: [],
                metrics: metrics as [String : NSNumber]?,
                views: views))
        }
        addVisualFormatConstraints("H:|[stack]|")
        addVisualFormatConstraints("H:|[separator]|")
        addVisualFormatConstraints("H:|[box(>=400)]|")
        addVisualFormatConstraints("V:|[stack(buttonHeight)][separator(==1)][box(>=400)]|")
        
        
        if childViewControllers.count > 0{
            selectTabAtIndex(0)
        }
    }
    
    override func insertChildViewController(_ childViewController: NSViewController, at index: Int) {
        super.insertChildViewController(childViewController, at: index)
        if isViewLoaded{
            reset()
        }
    }
    
    override func removeChildViewController(at index: Int) {
        super.removeChildViewController(at: index)
        if isViewLoaded{
            reset()
        }
    }
}
