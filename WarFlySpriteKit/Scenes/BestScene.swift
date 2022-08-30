//
//  BestScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 30.08.2022.
//

import SpriteKit

class BestScene: ParentScene {
    override func didMove(to view: SKView) {
        
        setHeader(withName: "best", andBackground: "header_background")
        
        let score = getMenuButton(withName: "score", title: "10 467",
                                  location: CGPoint(x: self.frame.midX, y: self.frame.midY),
                                  backgroundName: "button_background")
        addChild(score)
        
        let back = getMenuButton(withName: "back", title: "back",
                                 location: CGPoint(x: self.frame.midX, y: self.frame.midY - 100),
                                 backgroundName: "button_background")
        addChild(back)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let node = self.atPoint(location)
        
       if node.name == "back" {
           makeTheTransition(to: backScene, handler: nil)
        }
    }
}
