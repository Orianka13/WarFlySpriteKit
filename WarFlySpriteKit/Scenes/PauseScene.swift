//
//  PauseScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 25.08.2022.
//

import SpriteKit

class PauseScene: ParentScene {
    
    override func didMove(to view: SKView) {
        
        setHeader(withName: "pause", andBackground: "header_background")
        
        let titles = ["restart", "options", "resume"]
        
        setMenuButtons(withTitle: titles)
    }

    override func update(_ currentTime: TimeInterval) {
        if let gameScene = self.sceneManager.gameScene {
            if !gameScene.isPaused {
                gameScene.isPaused = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return } 
        let node = self.atPoint(location)
        
        if node.name == "restart" {
            self.sceneManager.gameScene = nil
            makeTheTransition(to: GameScene(size: self.size), handler: nil)
            
        } else if node.name == "resume" {
            makeTheTransition(to: self.sceneManager.gameScene, handler: nil)
            
        } else if node.name == "options" {
            makeTheTransition(to: OptionsScene(size: self.size)) { scene in
                scene.backScene = self
            }
        }
    }
}
