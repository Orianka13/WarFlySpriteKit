//
//  GameSettings.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 01.09.2022.
//

import UIKit

class GameSettings: NSObject {
    
    private let ud = UserDefaults.standard
    
    var isMusic = true
    var isSound = true
    
    private let musicKey = "music"
    private let soundKey = "sound"
    
    override init() {
        super.init()
        self.loadGameSettings()
    }
    
    func saveGameSettings() {
        self.ud.set(isMusic, forKey: musicKey)
        self.ud.set(isSound, forKey: soundKey)
    }
    
    func loadGameSettings() {
        guard ud.value(forKey: musicKey) != nil && ud.value(forKey: soundKey) != nil else { return }
        self.isMusic = ud.bool(forKey: musicKey)
        self.isSound = ud.bool(forKey: soundKey)
    }
}
