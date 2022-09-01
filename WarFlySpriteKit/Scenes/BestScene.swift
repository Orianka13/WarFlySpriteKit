//
//  BestScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 30.08.2022.
//

import SpriteKit

class BestScene: ParentScene {
    
    private var places: [Int]?
    
    override func didMove(to view: SKView) {
        
        setHeader(withName: "best", andBackground: "header_background")
        
        let back = getMenuButton(withName: "back", title: "back",
                                 location: CGPoint(x: self.frame.midX, y: self.frame.midY - 200),
                                 backgroundName: "button_background")
        addChild(back)
        
        gameSettings.loadScores()
        self.places = gameSettings.highScore
        guard let places = self.places else { return }
        
        for (index, value) in places.enumerated() {
            let l = SKLabelNode(text: value.description)
            l.fontColor = UIColor(red: 219 / 255, green: 226 / 255, blue: 215 / 255, alpha: 1.0)
            l.fontName = "AmericanTypewriter-Bold"
            l.fontSize = 30
            l.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index * 60))
            addChild(l)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let node = self.atPoint(location)
        
       if node.name == "back" {
           makeTheTransition(to: backScene, handler: nil)
        }
    }
}
