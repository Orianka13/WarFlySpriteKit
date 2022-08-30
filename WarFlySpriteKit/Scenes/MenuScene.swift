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
        
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        
        setHeader(withName: nil, andBackground: "header1")
        
        let titles = ["play", "options", "best"]
        
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(title: title, backgroundName: "button_background")
            
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index) * 100)
            button.name = title
            button.label.name = title
            addChild(button)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return } //добираемся до области касания, берем первое касание
        let node = self.atPoint(location) //получили объект куда мы тыкнули
        
        if node.name == "play" { //если нода это кнопка то осуществляем переход
            let transition = SKTransition.crossFade(withDuration: 1)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            
            self.scene?.view?.presentScene(gameScene, transition: transition)
        }
    }
}
