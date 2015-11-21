//
//  Audio.swift
//  VOWL
//
//  Created by Daniel Clelland on 15/11/15.
//  Copyright © 2015 Daniel Clelland. All rights reserved.
//

import UIKit

class Audio {
    
    static let shared = Audio()
    
    let synthesizer: Synthesizer
    
    let sopranoVocoder: Vocoder
    let altoVocoder: Vocoder
    let tenorVocoder: Vocoder
    let bassVocoder: Vocoder
    
    let master: Master
    
    init() {
        self.synthesizer = Synthesizer()
        
        self.sopranoVocoder = Vocoder.init(withInput: self.synthesizer.output)
        self.altoVocoder = Vocoder.init(withInput: self.synthesizer.output)
        self.tenorVocoder = Vocoder.init(withInput: self.synthesizer.output)
        self.bassVocoder = Vocoder.init(withInput: self.synthesizer.output)
        
        self.master = Master.init(
            withInput: self.synthesizer.output,
            voices: (
                self.sopranoVocoder.output,
                self.altoVocoder.output,
                self.tenorVocoder.output,
                self.bassVocoder.output
            )
        )
    }
    
    // MARK: - Getters
    
    func instruments() -> [AKInstrument] {
        return [
            self.synthesizer,
            self.sopranoVocoder,
            self.altoVocoder,
            self.tenorVocoder,
            self.bassVocoder,
            self.master
        ]
    }
    
    // MARK: - Life cycle
    
    func start() {
        for instrument in self.instruments() {
            AKOrchestra.addInstrument(instrument)
        }
        
        AKOrchestra.start()
    }
    
    func play() {
        for instrument in self.instruments() {
            instrument.play()
        }
    }
    
    func stop() {
        for instrument in self.instruments() {
            instrument.stop()
        }
    }

}
