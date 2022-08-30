//
//  PauseScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 25.08.2022.
//

import SpriteKit

class PauseScene: ParentScene {
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = backgoundColor
        
        setHeader(withName: "pause", andBackground: "header_background")
        
        let titles = ["restart", "options", "resume"]
        
        setMenuButtons(withTitle: titles)
    }
    //принудительно ставим сцену на паузу потому что баг в спрайт кит и пауза слетает
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
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            
            self.scene?.view?.presentScene(gameScene, transition: transition)
        } else if node.name == "resume" {
            let transition = SKTransition.crossFade(withDuration: 1)
            guard let gameScene = self.sceneManager.gameScene else { return }
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition)
            
        } else if node.name == "options" {
            let transition = SKTransition.crossFade(withDuration: 1)
            let optionsScene = OptionsScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(optionsScene, transition: transition)
        }
    }
}
