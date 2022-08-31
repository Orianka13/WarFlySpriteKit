//
//  BluePowerUp.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 15.08.2022.
//

import SpriteKit

final class BluePowerUp: PowerUp {
    init() {
        let textureAtlas = Assets.shared.bluePowerUpAtlas
        super.init(textureAtlas: textureAtlas)
        name = "bluePowerUp"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
