//
//  OptionsScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 30.08.2022.
//

import SpriteKit

class OptionsScene: ParentScene {
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = backgoundColor
        
        setHeader(withName: "options", andBackground: "header_background")
        
        let music = ButtonNode(title: nil, backgroundName: "music")
        music.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY)
        music.name = "music"
        music.label.isHidden = true
        addChild(music)
        
        let sound = ButtonNode(title: nil, backgroundName: "sound")
        sound.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY)
        sound.name = "sound"
        sound.label.isHidden = true
        addChild(sound)
        
        let back = ButtonNode(title: "back", backgroundName: "button_background")
        back.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
        back.name = "back"
        back.label.name = "back"
        addChild(back)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let node = self.atPoint(location)
        
        if node.name == "music" {
            print("music")
        } else if node.name == "sound" {
            print("sound")
        } else if node.name == "back" {
            let transition = SKTransition.crossFade(withDuration: 1)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(backScene, transition: transition)
        }
    }
}


