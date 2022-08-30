//
//  ParentScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 30.08.2022.
//

import SpriteKit

class ParentScene: SKScene {
    
    let sceneManager = SceneManager.shared
    
    var backScene: SKScene?
    
    func setHeader(withName name: String?, andBackground backgroundName: String) {
        let header = ButtonNode(title: name, backgroundName: backgroundName)
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        self.addChild(header)
    }
}
