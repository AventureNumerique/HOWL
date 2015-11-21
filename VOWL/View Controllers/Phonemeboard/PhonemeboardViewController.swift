//
//  PhonemeboardViewController.swift
//  VOWL
//
//  Created by Daniel Clelland on 14/11/15.
//  Copyright © 2015 Daniel Clelland. All rights reserved.
//

import UIKit

class PhonemeboardViewController: UIViewController, MultitouchGestureRecognizerDelegate {
    
    @IBOutlet weak var phonemeboardView: PhonemeboardView?
    
    @IBOutlet weak var multitouchGestureRecognizer: MultitouchGestureRecognizer?
    
    @IBOutlet weak var holdButton: HoldButton? {
        didSet {
            holdButton?.selected = Settings.shared.phonemeboardSustain
        }
    }
    
    let phonemeboard = Phonemeboard()
    
    // MARK: - Life cycle
    
    func refreshView() {
        guard let touches = self.multitouchGestureRecognizer?.touches else {
            return
        }
        
        self.phonemeboardView?.state = self.stateForTouches(touches)
        
        if let hue = self.hueForTouches(touches), let saturation = self.saturationForTouches(touches) {
            self.phonemeboardView?.hue = hue
            self.phonemeboardView?.saturation = saturation
        }
    }
    
    func refreshAudio() {
        guard let touches = self.multitouchGestureRecognizer?.touches else {
            return
        }
        
        if touches.count == 0 {
            Audio.shared.sopranoVocoder.mute()
            Audio.shared.altoVocoder.mute()
            Audio.shared.tenorVocoder.mute()
            Audio.shared.bassVocoder.mute()
        } else {
            Audio.shared.sopranoVocoder.unmute()
            Audio.shared.altoVocoder.unmute()
            Audio.shared.tenorVocoder.unmute()
            Audio.shared.bassVocoder.unmute()
        }
        
        if let (soprano, alto, tenor, bass) = self.phonemesForTouches(touches) {
            Audio.shared.sopranoVocoder.updateWithPhoneme(soprano)
            Audio.shared.altoVocoder.updateWithPhoneme(alto)
            Audio.shared.tenorVocoder.updateWithPhoneme(tenor)
            Audio.shared.bassVocoder.updateWithPhoneme(bass)
        }
        
    }
    
    // MARK: - Interface events
    
    @IBAction func holdButtonTapped(button: HoldButton) {
        Settings.shared.phonemeboardSustain = !Settings.shared.phonemeboardSustain
        button.selected = Settings.shared.phonemeboardSustain
        
        if !button.selected {
            self.multitouchGestureRecognizer?.endTouches()
        }
    }
    
    // MARK: - Multitouch gesture recognizer delegate
    
    func multitouchGestureRecognizerShouldSustainTouches(gestureRecognizer: MultitouchGestureRecognizer) -> Bool {
        return Settings.shared.phonemeboardSustain
    }
    
    func multitouchGestureRecognizer(gestureRecognizer: MultitouchGestureRecognizer, touchDidBegin touch: UITouch) {
        self.refreshView()
        self.refreshAudio()
    }
    
    func multitouchGestureRecognizer(gestureRecognizer: MultitouchGestureRecognizer, touchDidMove touch: UITouch) {
        self.refreshView()
        self.refreshAudio()
    }
    
    func multitouchGestureRecognizer(gestureRecognizer: MultitouchGestureRecognizer, touchDidCancel touch: UITouch) {
        self.refreshView()
        self.refreshAudio()
    }
    
    func multitouchGestureRecognizer(gestureRecognizer: MultitouchGestureRecognizer, touchDidEnd touch: UITouch) {
        self.refreshView()
        self.refreshAudio()
    }
    
    // MARK: - Private Getters
    
    private func phonemesForTouches(touches: [UITouch]) -> (Phoneme, Phoneme, Phoneme, Phoneme)? {
        guard let location = self.locationForTouches(touches) else {
            return nil
        }
        
        let soprano = self.phonemeboard.sopranoPhonemeAtLocation(location)
        let alto = self.phonemeboard.altoPhonemeAtLocation(location)
        let tenor = self.phonemeboard.tenorPhonemeAtLocation(location)
        let bass = self.phonemeboard.bassPhonemeAtLocation(location)
        
        return (soprano, alto, tenor, bass)
    }
    
    private func stateForTouches(touches: [UITouch]) -> PhonemeboardViewState {
        if touches.count == 0 {
            return .Normal
        }
        
        let liveTouches = touches.filter { (touch) -> Bool in
            switch touch.phase {
            case .Began:
                return true
            case .Moved:
                return true
            case .Stationary:
                return true
            case .Cancelled:
                return false
            case .Ended:
                return false
            }
        }
        
        if liveTouches.count > 0 {
            return .Highlighted
        } else {
            return .Selected
        }
    }
    
    private func hueForTouches(touches: [UITouch]) -> CGFloat? {
        guard let location = self.locationForTouches(touches) else {
            return nil
        }
        
        let offset = CGVectorMake(location.x - 0.5, location.y - 0.5)
        let angle = atan2(offset.dx, offset.dy)
        
        return (angle + CGFloat(M_PI)) / (2.0 * CGFloat(M_PI))
    }
    
    private func saturationForTouches(touches: [UITouch]) -> CGFloat? {
        guard let location = self.locationForTouches(touches) else {
            return nil
        }

        let offset = CGVectorMake(location.x - 0.5, location.y - 0.5)
        let distance = hypot(offset.dx, offset.dy)

        return distance * 2.0
    }
    
    private func locationForTouches(touches: [UITouch]) -> CGPoint? {
        guard let phonemeboardView = self.phonemeboardView where touches.count > 0 else {
            return nil
        }
        
        let location = touches.reduce(CGPointZero) { (location, touch) -> CGPoint in
            let touchLocation = touch.locationInView(phonemeboardView)
            
            let x = location.x + touchLocation.x / CGFloat(touches.count)
            let y = location.y + touchLocation.y / CGFloat(touches.count)
            
            return CGPointMake(x, y)
        }
        
        return CGPointApplyAffineTransform(location, phonemeboardView.bounds.normalizationTransform())
    }
    
}
