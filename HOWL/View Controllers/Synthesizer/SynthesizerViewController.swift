//
//  SynthesizerViewController.swift
//  HOWL
//
//  Created by Daniel Clelland on 1/12/15.
//  Copyright © 2015 Daniel Clelland. All rights reserved.
//

import UIKit

class SynthesizerViewController: UIViewController {
    
    @IBOutlet weak var vibratoDepthDialControl: DialControl?
    @IBOutlet weak var vibratoFrequencyDialControl: DialControl?
    
    @IBOutlet weak var keyboardLeftIntervalDialControl: DialControl?
    @IBOutlet weak var keyboardRightIntervalDialControl: DialControl?
    
    // MARK: - Interface events
    
    @IBAction func flipButtonTapped(button: ToolbarButton) {
        flipViewController?.flip()
    }
    
    @IBAction func resetButtonTapped(button: ToolbarButton) {
        vibratoDepthDialControl?.value = 0.0
        vibratoFrequencyDialControl?.value = 0.0
        keyboardLeftIntervalDialControl?.value = 4.0
        keyboardRightIntervalDialControl?.value = 7.0
    }
    
    // MARK: - Dial control events
    
    @IBAction func vibratoDepthDialControlValueChanged(dialControl: DialControl) {
        
    }
    
    @IBAction func vibratoFrequencyDialControlValueChanged(dialControl: DialControl) {
        
    }
    
    @IBAction func keyboardLeftIntervalDialControlValueChanged(dialControl: DialControl) {
        
    }
    
    @IBAction func keyboardRightIntervalDialControlValueChanged(dialControl: DialControl) {
        
    }
    
}
