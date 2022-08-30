//
//  ParentScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 30.08.2022.
//

import SpriteKit

class ParentScene: SKScene {
    
    let sceneManager = SceneManager.shared
    let backgoundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
    var backScene: SKScene?
    
    func setHeader(withName name: String?, andBackground backgroundName: String) {
        let header = ButtonNode(title: name, backgroundName: backgroundName)
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        self.addChild(header)
    }
    
    func setMenuButtons(withTitle titleArray: [String]) {
        for (index, title) in titleArray.enumerated() {
            let button = ButtonNode(title: title, backgroundName: "button_background")
            
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index) * 100)
            button.name = title
            button.label.name = title
            addChild(button)
        }
    }
}
