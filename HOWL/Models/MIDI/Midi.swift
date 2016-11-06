//
//  MIDI.swift
//  HOWL
//
//  Created by Daniel Clelland on 6/11/16.
//  Copyright © 2016 Daniel Clelland. All rights reserved.
//

import Foundation
import AudioKit

class Midi {

    // MARK: Client
    
    static var client: Midi?
    
    // MARK: Actions
    
    static let didStartNotification = NSNotification.Name("MIDIDidStartNotification")
    
    static func start() {
        guard AKSettings.shared().midiEnabled else {
            return
        }
        
        client = Midi()
        
        NotificationCenter.default.post(name: didStartNotification, object: nil, userInfo: nil)
    }
    
    static let didStopNotification = NSNotification.Name("MIDIDidStopNotification")
    
    static func stop() {
        guard AKManager.shared().isRunning == true else {
            return
        }
        
        client = nil
        
        NotificationCenter.default.post(name: didStopNotification, object: nil, userInfo: nil)
    }
    
    // MARK: Initialization
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiNoteOn(notification:)), name: .AKMidiNoteOn, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiNoteOff(notification:)), name: .AKMidiNoteOff, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiPolyphonicAfterTouch(notification:)), name: .AKMidiPolyphonicAftertouch, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiProgramChange(notification:)), name: .AKMidiProgramChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiAftertouch(notification:)), name: .AKMidiAftertouch, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiPitchWheel(notification:)), name: .AKMidiPitchWheel, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiController(notification:)), name: .AKMidiController, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiModulation(notification:)), name: .AKMidiModulation, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiPortamento(notification:)), name: .AKMidiPortamento, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiVolume(notification:)), name: .AKMidiVolume, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiBalance(notification:)), name: .AKMidiBalance, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiPan(notification:)), name: .AKMidiPan, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiExpression(notification:)), name: .AKMidiExpression, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Midi.midiControl(notification:)), name: .AKMidiControl, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Notifications
    
    @objc fileprivate func midiNoteOn(notification: Notification) {
        print("Note on: \(notification.object), \(notification.userInfo)")
    }
    
    @objc fileprivate func midiNoteOff(notification: Notification) {
        print("Note off: \(notification.object), \(notification.userInfo)")
    }
    
    @objc fileprivate func midiPolyphonicAfterTouch(notification: Notification) {
        print("Polyphonic aftertouch: \(notification.object), \(notification.userInfo)")
    }
    
    @objc fileprivate func midiProgramChange(notification: Notification) {
        print("Program change: \(notification.object), \(notification.userInfo)")
    }
    
    @objc fileprivate func midiAftertouch(notification: Notification) {
        print("After touch: \(notification.object), \(notification.userInfo)")
    }
    
    @objc fileprivate func midiPitchWheel(notification: Notification) {
        print("Pitch wheel: \(notification.object), \(notification.userInfo)")
    }
    
    @objc fileprivate func midiController(notification: Notification) {
        print("Midi controller: \(notification.object), \(notification.userInfo)")
    }
    
    @objc fileprivate func midiModulation(notification: Notification) {
        print("Midi modulation: \(notification.object), \(notification.userInfo)")
    }
    
    @objc fileprivate func midiPortamento(notification: Notification) {
        print("Midi portamento: \(notification.object), \(notification.userInfo)")
    }
    
    @objc fileprivate func midiVolume(notification: Notification) {
        print("Midi volume: \(notification.object), \(notification.userInfo)")
    }
    
    @objc fileprivate func midiBalance(notification: Notification) {
        print("Midi balance: \(notification.object), \(notification.userInfo)")
    }
    
    @objc fileprivate func midiPan(notification: Notification) {
        print("Midi pan: \(notification.object), \(notification.userInfo)")
    }
    
    @objc fileprivate func midiExpression(notification: Notification) {
        print("Midi expression: \(notification.object), \(notification.userInfo)")
    }
    
    @objc fileprivate func midiControl(notification: Notification) {
        print("Midi control: \(notification.object), \(notification.userInfo)")
    }
    
}
