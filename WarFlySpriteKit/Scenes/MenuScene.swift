//
//  MenuScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 16.08.2022.
//

import SpriteKit

class MenuScene: ParentScene {
    override func didMove(to view: SKView) {
        
        if !Assets.shared.isLoaded {
            Assets.shared.preloadAssets()
            Assets.shared.isLoaded = true
        }
        
        self.backgroundColor = backgoundColor
        
        setHeader(withName: nil, andBackground: "header1")
        
        let titles = ["play", "options", "best"]
        
        setMenuButtons(withTitle: titles)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return } //добираемся до области касания, берем первое касание
        let node = self.atPoint(location) //получили объект куда мы тыкнули
        
        if node.name == "play" { //если нода это кнопка то осуществляем переход
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            
            self.scene?.view?.presentScene(gameScene, transition: transition)
            
        } else if node.name == "options" {
            let transition = SKTransition.crossFade(withDuration: 1)
            let optionsScene = OptionsScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(optionsScene, transition: transition)
            
        } else if node.name == "best" {
            let transition = SKTransition.crossFade(withDuration: 1)
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self
            bestScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(bestScene, transition: transition)
        }
    }
}
