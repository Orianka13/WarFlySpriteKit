//
//  HUD.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 25.08.2022.
//

import SpriteKit

class HUD: SKScene {
    private let scoreBackground = SKSpriteNode(imageNamed: "scores")
    private let scoreLabel = SKLabelNode(text: "10 000")
    private let menuButton = SKSpriteNode(imageNamed: "menu")
    private let life1 = SKSpriteNode(imageNamed: "life")
    private let life2 = SKSpriteNode(imageNamed: "life")
    private let life3 = SKSpriteNode(imageNamed: "life")
    
    func configureUI(screenSize: CGSize, layotSize: CGSize) {
        self.scoreBackground.anchorPoint = CGPoint(x: 0.0, y: 1.0)
        self.scoreBackground.position = CGPoint(x: scoreBackground.size.width + 10,
                                                y: layotSize.height )
        self.scoreBackground.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        self.scoreBackground.zPosition = 99
        self.addChild(scoreBackground)
        
        self.scoreLabel.horizontalAlignmentMode = .right
        self.scoreLabel.verticalAlignmentMode = .center
        self.scoreLabel.position = CGPoint(x: -10, y: 3)
        self.scoreLabel.zPosition = 100
        self.scoreLabel.fontName = "AmericanTypewriter-Bold"
        self.scoreLabel.fontSize = 30
        self.scoreBackground.addChild(scoreLabel)
        
        self.menuButton.position = CGPoint(x: 20, y: 20)
        self.menuButton.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        self.menuButton.zPosition = 100
        self.addChild(menuButton)
        
        let width = screenSize.width - 20
        
        let lifes = [life1, life2, life3]
        for (index, life) in lifes.enumerated() {
            life.position = CGPoint(x: width - CGFloat(index + 1) * life.size.width + 3,
                                    y: 20)
            life.zPosition = 100
            life.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            self.addChild(life)
            
        }
    }
    
}
