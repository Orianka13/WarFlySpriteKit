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
    
    var highScore = [Int]()
    var currentScore = 0
    let highScoreKey = "highScore"
    
    private let musicKey = "music"
    private let soundKey = "sound"
    
    override init() {
        super.init()
        self.loadGameSettings()
        self.loadScores()
    }
    
    func saveScores() {
        self.highScore.append(currentScore)
        self.highScore = Array(self.highScore.sorted{ $0 > $1 }.prefix(3))
        
        ud.set(self.highScore, forKey: self.highScoreKey)
        ud.synchronize()
    }
    
    func loadScores() {
        guard self.ud.value(forKey: self.highScoreKey) != nil else { return }
        self.highScore = self.ud.array(forKey: self.highScoreKey) as! [Int]
        
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
