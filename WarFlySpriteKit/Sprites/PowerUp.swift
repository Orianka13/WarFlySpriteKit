//
//  PowerUp.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 08.08.2022.
//

import UIKit
import SpriteKit

class PowerUp: SKSpriteNode {
    
    private let initialSize = CGSize(width: 52, height: 52)
    private let textureAtlas = SKTextureAtlas(named: "GreenPowerUp")
    private var animationSpriteArray = [SKTexture]()
    
    //вызываем дезигнейтет инит
    init() {
        let greenTexture = textureAtlas.textureNamed("missle_green_01")
        super.init(texture: greenTexture, color: .clear, size: self.initialSize)
        self.name = "powerUp" //присвоили имя нашем спрайту
        self.zPosition = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //создадим анимацию
    func performRotation() {
        for i in 1...15 {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "missle_green_\(number)")
            self.animationSpriteArray.append(texture)
        }
        SKTexture.preload(self.animationSpriteArray) {
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
    }
    
}
