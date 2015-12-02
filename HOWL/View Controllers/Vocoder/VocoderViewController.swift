//
//  VocoderViewController.swift
//  HOWL
//
//  Created by Daniel Clelland on 1/12/15.
//  Copyright © 2015 Daniel Clelland. All rights reserved.
//

import UIKit

class VocoderViewController: UIViewController {
    
    // MARK: - Interface events
    
    @IBAction func flipButtonTapped(button: ToolbarButton) {
        if let flipViewController = self.flipViewController {
            flipViewController.flip()
        }
    }
    
    @IBAction func resetButtonTapped(button: ToolbarButton) {
        
    }
    
}
