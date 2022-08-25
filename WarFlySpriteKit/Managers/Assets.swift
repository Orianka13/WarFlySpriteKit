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
        self.yellowAmmoAtlas.preload { print("yellowAmmoAtlas preloaded") }
        self.bluePowerUpAtlas.preload { print("bluePowerUpAtlas preloaded") }
        self.playerPlaneAtlas.preload { print("playerPlaneAtlas preloaded") }
        self.greenPowerUpAtlas.preload { print("greenPowerUpAtlas preloaded") }
        self.enemy_1Atlas.preload { print("enemy_1Atlas preloaded") }
        self.enemy_2Atlas.preload { print("enemy_2Atlas preloaded") }
    }
}
