//
//  Keyboard.swift
//  VOWL
//
//  Created by Daniel Clelland on 15/11/15.
//  Copyright © 2015 Daniel Clelland. All rights reserved.
//

import UIKit

struct KeyboardCoordinate {
    var leftAxis: Int
    var rightAxis: Int
    
    init(withLeftAxis leftAxis: Int, rightAxis: Int) {
        self.leftAxis = leftAxis
        self.rightAxis = rightAxis
    }
}

struct KeyboardKey {
    var pitch: Int
    var selected: Bool
    
    init(withPitch pitch: Int, selected: Bool) {
        self.pitch = pitch
        self.selected = selected
    }
}

class Keyboard {
    
    var centerPitch = 40
    
    var leftAxisInterval = 4
    var rightAxisInterval = 7
    
    var verticalRadius = 5
    var horizontalRadius = 3
    
    func numberOfKeys() -> Int {
        let oddRowCount: Int = verticalRadius / 2 * 2 + 1
        let oddColumnCount: Int = horizontalRadius / 2 * 2 + 1
        let evenRowCount: Int = (verticalRadius + 1) / 2 * 2
        let evenColumnCount: Int = (horizontalRadius + 1) / 2 * 2
        
        return oddRowCount * oddColumnCount + evenRowCount * evenColumnCount
    }
    
    
    
    func pitchForCoordinate(coordinate: KeyboardCoordinate) -> Int {
        return centerPitch + coordinate.leftAxis * leftAxisInterval + coordinate.rightAxis * rightAxisInterval
    }
}
