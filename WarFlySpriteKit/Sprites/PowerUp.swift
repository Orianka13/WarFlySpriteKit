//
//  PowerUp.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 08.08.2022.
//

import SpriteKit


class PowerUp: SKSpriteNode {
    
    private let initialSize = CGSize(width: 52, height: 52)
    private let textureAtlas: SKTextureAtlas?
    private var animationSpriteArray = [SKTexture]()
    private var textureNameBeginsWith = ""
    
    //вызываем дезигнейтет инит
    init(textureAtlas: SKTextureAtlas) {
        self.textureAtlas = textureAtlas
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture = textureAtlas.textureNamed(textureName)
        self.textureNameBeginsWith = String(textureName.dropLast(6)) // 01.png
        super.init(texture: texture, color: .clear, size: self.initialSize)
        self.setScale(0.7)
        self.name = "sprite" //присвоили имя нашем спрайту
        self.zPosition = 20
        
        self.physicsBody = SKPhysicsBody(texture: texture,
                                                alphaThreshold: 0.5,
                                                size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.powerUp
        self.physicsBody?.collisionBitMask = BitMaskCategory.player
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMovement() {
        self.performRotation()
        
        let moveForvard = SKAction.moveTo(y: -100, duration: 5)
        self.run(moveForvard)
    }
    
    //создадим анимацию
    private func performRotation() {
        for i in 1...15 {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: self.textureNameBeginsWith + number.description)
            self.animationSpriteArray.append(texture)
        }
        SKTexture.preload(self.animationSpriteArray) {
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
    }
    
}
