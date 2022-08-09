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
    
    func flySpiral() {
        let screenSize = UIScreen.main.bounds
        let timeHorizontal: Double = 3
        let timeVertical: Double = 10
        let moveLeft = SKAction.moveTo(x: 55, duration: timeHorizontal) // 55 - половина от ширины самолета 221 * 0.5
        moveLeft.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: screenSize.width - 55, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        let asideMovementSequense = SKAction.sequence([moveLeft, moveRight])
        let sequenseForeverMovement = SKAction.repeatForever(asideMovementSequense)
        
        let forwardMovement = SKAction.moveTo(y: -105, duration: timeVertical)
        
        let groupMovement = SKAction.group([sequenseForeverMovement, forwardMovement])
        
        self.run(groupMovement)
    }
}
