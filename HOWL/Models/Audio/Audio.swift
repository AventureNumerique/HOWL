//
//  Audio.swift
//  HOWL
//
//  Created by Daniel Clelland on 15/11/15.
//  Copyright © 2015 Daniel Clelland. All rights reserved.
//

import AudioKit

struct Audio {
    
    static let synthesizer = Synthesizer()
    
    static let vocoders = [
        Vocoder.male(.Bass, withInput: synthesizer.output),
        Vocoder.male(.Tenor, withInput: synthesizer.output),
        Vocoder.male(.Alto, withInput: synthesizer.output),
        Vocoder.male(.Soprano, withInput: synthesizer.output)
    ]
    
    static let master = Master(
        withInput: synthesizer.output,
        voices: vocoders.map { $0.output }
    )
    
    static var instruments: [AKInstrument] {
        return [
            synthesizer,
            vocoders[0],
            vocoders[1],
            vocoders[2],
            vocoders[3],
            master
        ]
    }
    
    // MARK: - Life cycle
    
    static func start() {
        for instrument in instruments {
            AKOrchestra.addInstrument(instrument)
        }
        
        AKOrchestra.start()
    }
    
    static func play() {
        for instrument in instruments {
            instrument.play()
        }
    }
    
    static func stop() {
        for instrument in instruments {
            instrument.stop()
        }
    }

}
