//
//  Enemy.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 09.08.2022.
//

import SpriteKit

class Enemy: SKSpriteNode {
    
    private enum EnemyDirection: Int {
        case left = 0
        case right
    }

    static var textureAtlas: SKTextureAtlas?
    private var enemyTexture: SKTexture?
    
    init(enemyTexture: SKTexture) {
        let texture = enemyTexture
        super.init(texture: texture, color: .clear, size: CGSize(width: 221, height: 204))
        self.xScale = 0.5
        self.yScale = -0.5 //чтобы самолет смотрел в противоположную сторону(вниз)
        self.zPosition = 20
        self.name = "sprite" //чтобы удалять самолет по имени
        
        self.physicsBody = SKPhysicsBody(texture: texture,
                                                alphaThreshold: 0.5,
                                                size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.player.rawValue | BitMaskCategory.shot.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue | BitMaskCategory.shot.rawValue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flySpiral() {
        let screenSize = UIScreen.main.bounds
        let timeHorizontal: Double = 3
        let timeVertical: Double = 5
        
        let moveLeft = SKAction.moveTo(x: 55, duration: timeHorizontal) // 55 - половина от ширины самолета 221 * 0.5
        moveLeft.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: screenSize.width - 55, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        
        let randomNumber = Int(arc4random_uniform(2)) //рандомное число до 2, т.е 0 и 1
        
        let asideMovementSequense = randomNumber == EnemyDirection.left.rawValue ? SKAction.sequence([moveLeft, moveRight]) : SKAction.sequence([moveRight, moveLeft])
     
        let sequenseForeverMovement = SKAction.repeatForever(asideMovementSequense)
        
        let forwardMovement = SKAction.moveTo(y: -105, duration: timeVertical)
        
        let groupMovement = SKAction.group([sequenseForeverMovement, forwardMovement])
        
        self.run(groupMovement)
    }
}
