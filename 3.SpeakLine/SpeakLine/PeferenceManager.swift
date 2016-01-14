//
//  PeferenceManager.swift
//  SpeakLine
//
//  Created by fancymax on 15/8/14.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Cocoa

class PeferenceManager {
    private var activeVoiceKey = "activeVoice"
    private var activeTextKey = "activeText"
    
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    init()
    {
        registerUserDefault()
    }
    
    private func registerUserDefault()
    {
        let firstDefault = [activeVoiceKey: NSSpeechSynthesizer.defaultVoice(),
            activeTextKey:"I fuck your ass"]
        userDefaults.registerDefaults(firstDefault)
    }
    
    var activeText:String?{
        get{
            return userDefaults.objectForKey(activeTextKey) as? String
        }
        set(newText){
            userDefaults.setObject(newText, forKey: activeTextKey)
        }
    }
    
    var activeVoice:String?{
        get{
            return userDefaults.objectForKey(activeVoiceKey) as? String
        }
        set(newVoice){
            userDefaults.setObject(newVoice, forKey: activeVoiceKey)
        }
    }
}
