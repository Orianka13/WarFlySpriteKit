//
//  Enemy.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 09.08.2022.
//

import SpriteKit

class Enemy: SKSpriteNode {

    static var textureAtlas: SKTextureAtlas?
    
    init() {
        let texture = Enemy.textureAtlas?.textureNamed("airplane_4ver2_13")
        super.init(texture: texture, color: .clear, size: CGSize(width: 221, height: 204))
        self.xScale = 0.5
        self.yScale = -0.5 //чтобы самолет смотрел в противоположную сторону(вниз)
        self.zPosition = 20
        self.name = "sprite" //чтобы удалять самолет по имени
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
