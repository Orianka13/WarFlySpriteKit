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
    var backScene: ParentScene?
    
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
    
    func getMenuButton(withName name: String, title: String?, location: CGPoint, backgroundName: String) -> ButtonNode {
        let button = ButtonNode(title: title, backgroundName: backgroundName)
        button.position = location
        button.name = name
        button.label.name = title
        return button
    }
    
    func makeTheTransition(to scene: ParentScene?, handler: ((ParentScene) -> Void)?) {
        let transition = SKTransition.crossFade(withDuration: 1)
        guard let scene = scene else { return }
        scene.scaleMode = .aspectFill
        handler?(scene)
        self.scene?.view?.presentScene(scene, transition: transition)
    }
}
