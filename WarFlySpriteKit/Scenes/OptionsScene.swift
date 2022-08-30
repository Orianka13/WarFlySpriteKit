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
        
        let music = getMenuButton(withName: "music", title: nil,
                                  location: CGPoint(x: self.frame.midX - 50, y: self.frame.midY),
                                  backgroundName: "music")
        addChild(music)
        
        let sound = getMenuButton(withName: "sound", title: nil,
                                  location: CGPoint(x: self.frame.midX + 50, y: self.frame.midY),
                                  backgroundName: "sound")
        addChild(sound)
        
        let back = getMenuButton(withName: "back", title: "back",
                                 location: CGPoint(x: self.frame.midX, y: self.frame.midY - 100),
                                 backgroundName: "button_background")
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
            makeTheTransition(to: backScene, handler: nil)
        }
    }
}


