//
//  GreenPowerUp.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 15.08.2022.
//

import SpriteKit

final class GreenPowerUp: PowerUp {
    init() {
        let textureAtlas = SKTextureAtlas(named: "GreenPowerUp")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
