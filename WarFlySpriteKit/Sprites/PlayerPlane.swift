//
//  PlayerPlane.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 04.08.2022.
//

import SpriteKit

class PlayerPlane: SKSpriteNode {

    static func populate(at point: CGPoint) -> SKSpriteNode {
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13") //текстура меняться может а изображение нет (к текстуре можем применить покадровую анимацию)
        let playerPlane = SKSpriteNode(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 20
        
        return playerPlane
    }
    
}
