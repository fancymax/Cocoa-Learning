//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by fancymax on 15/7/27.
//  Copyright (c) 2015年 fancy. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController,NSSpeechSynthesizerDelegate,NSTableViewDataSource,NSTableViewDelegate,NSTextFieldDelegate{

    @IBOutlet weak var speakLine: NSTextField!
    
    @IBOutlet weak var voiceTableList: NSTableView!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    let speaker = NSSpeechSynthesizer()
    let voices = NSSpeechSynthesizer.availableVoices() 
    let peferenceManager = PeferenceManager()
    
    var isSpeaking = false{
        didSet{
            speakButton.enabled = !isSpeaking
        }
    }
    
    @IBAction func speakIt(sender: NSButton) {
        speaker.startSpeakingString(speakLine.stringValue)
        isSpeaking = true
    }
    
    @IBAction func StopIt(sender: NSButton) {
        speaker.stopSpeaking()
        isSpeaking = false
    }
    
    override func controlTextDidChange(obj: NSNotification) {
        peferenceManager.activeText = speakLine.stringValue
    }
    
    
    
    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        print("\(finishedSpeaking)")
            isSpeaking = false
    }
    
    func voiceNameForIdentifier(voice:String) ->String?
    {
        let attributeDictionary = NSSpeechSynthesizer.attributesForVoice(voice)
        return attributeDictionary[NSVoiceName] as? String
        
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let voiceIdentifier = voices[voiceTableList.selectedRow]
        speaker.setVoice(voiceIdentifier)
        
        peferenceManager.activeVoice = voiceIdentifier
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return voices.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return voiceNameForIdentifier(voices[row])
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        speaker.delegate = self
        
        let defautVoice = peferenceManager.activeVoice!
        speakLine.stringValue = peferenceManager.activeText!
        
        print("\(defautVoice)")
        print("\(voices)")
        if let defaultRow = voices.indexOf(defautVoice)
        {
            print("\(defaultRow)")
            let defaultIndex = NSIndexSet(index: defaultRow)
            voiceTableList.selectRowIndexes(defaultIndex, byExtendingSelection: false)
            voiceTableList.scrollRowToVisible(defaultRow)
        }
    }
    
}
