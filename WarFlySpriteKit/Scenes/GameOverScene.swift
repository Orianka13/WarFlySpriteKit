//
//  GameOverScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 31.08.2022.
//

import SpriteKit

class GameOverScene: ParentScene {
    override func didMove(to view: SKView) {
        
        setHeader(withName: "game over", andBackground: "header_background")
        
        let titles = ["restart", "options", "best"]
        
        setMenuButtons(withTitle: titles)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let node = self.atPoint(location)
        
        if node.name == "restart" {
            self.sceneManager.gameScene = nil
            makeTheTransition(to: GameScene(size: self.size), handler: nil)
            
        } else if node.name == "options" {
            makeTheTransition(to: OptionsScene(size: self.size)) { scene in
                scene.backScene = self
            }
        } else if node.name == "best" {
            makeTheTransition(to: BestScene(size: self.size)) { scene in
                scene.backScene = self
            }
        }
    }
}
