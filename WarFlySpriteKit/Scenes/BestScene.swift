//
//  BestScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 30.08.2022.
//

import SpriteKit

class BestScene: ParentScene {
    override func didMove(to view: SKView) {
        
        self.backgroundColor = backgoundColor
        
        setHeader(withName: "best", andBackground: "header_background")
        
        let score = ButtonNode(title: "10 467", backgroundName: "button_background")
        score.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        score.name = "score"
        score.label.name = "10 467"
        addChild(score)
        
        let back = ButtonNode(title: "back", backgroundName: "button_background")
        back.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        back.name = "back"
        back.label.name = "back"
        addChild(back)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let node = self.atPoint(location)
        
       if node.name == "back" {
            let transition = SKTransition.crossFade(withDuration: 1)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(backScene, transition: transition)
        }
    }
}
