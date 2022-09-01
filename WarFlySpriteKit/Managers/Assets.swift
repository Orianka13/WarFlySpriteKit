//
//  Assets.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 16.08.2022.
//

import SpriteKit

final class Assets {
    static let shared = Assets()
    
    var isLoaded = false
    
    let yellowAmmoAtlas = SKTextureAtlas(named: "YellowAmmo")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
    
    func preloadAssets() {
        self.yellowAmmoAtlas.preload {}
        self.bluePowerUpAtlas.preload {}
        self.playerPlaneAtlas.preload {}
        self.greenPowerUpAtlas.preload {}
        self.enemy_1Atlas.preload {}
        self.enemy_2Atlas.preload {}
    }
}
