//
//  Shot.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 16.08.2022.
//

import SpriteKit

class Shot: SKSpriteNode {
    private let screenSize = UIScreen.main.bounds

    private let initialSize = CGSize(width: 187, height: 237)
    private let textureAtlas: SKTextureAtlas?
    private var animationSpriteArray = [SKTexture]()
    private var textureNameBeginsWith = ""
    
    init(textureAtlas: SKTextureAtlas) {
        self.textureAtlas = textureAtlas
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture = textureAtlas.textureNamed(textureName)
        self.textureNameBeginsWith = String(textureName.dropLast(6))
        super.init(texture: texture, color: .clear, size: self.initialSize)
        self.setScale(0.5)
        self.name = "shotSprite"
        self.zPosition = 30
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMovement() {
        self.performRotation()
        
        let moveForvard = SKAction.moveTo(y: self.screenSize.height + 100, duration: 2)
        self.run(moveForvard)
    }
    
    private func performRotation() {
        for i in 1...32 {
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
