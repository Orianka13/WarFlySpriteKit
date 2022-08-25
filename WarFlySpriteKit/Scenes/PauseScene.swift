//
//  PauseScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 25.08.2022.
//

import SpriteKit

class PauseScene: SKScene {
    override func didMove(to view: SKView) {
        
        
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        
        let header = ButtonNode(title: "pause", backgroundName: "header_background")
        
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        
        self.addChild(header)
        
        let titles = ["restart", "options", "resume"]
        
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(title: title, backgroundName: "button_background")
            
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index) * 100)
            button.name = title
            button.label.name = title
            addChild(button)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return } 
        let node = self.atPoint(location)
        
        if node.name == "restart" {
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
    }
}
