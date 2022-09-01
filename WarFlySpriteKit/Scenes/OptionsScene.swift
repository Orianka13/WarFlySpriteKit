//
//  OptionsScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 30.08.2022.
//

import SpriteKit

class OptionsScene: ParentScene {
    
    private var isMusic: Bool!
    private var isSound: Bool!
    
    override func didMove(to view: SKView) {
        
        self.isMusic = gameSettings.isMusic
        self.isSound = gameSettings.isSound
        
        setHeader(withName: "options", andBackground: "header_background")
        
        let backgroundNameForMusic = isMusic == true ? "music" : "nomusic"
        
        let music = getMenuButton(withName: "music", title: nil,
                                  location: CGPoint(x: self.frame.midX - 50, y: self.frame.midY),
                                  backgroundName: backgroundNameForMusic)
        addChild(music)
        
        let backgroundNameForSound = self.isMusic == true ? "sound" : "nosound"
        let sound = getMenuButton(withName: "sound", title: nil,
                                  location: CGPoint(x: self.frame.midX + 50, y: self.frame.midY),
                                  backgroundName: backgroundNameForSound)
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
            isMusic = !isMusic
            update(node: node as! SKSpriteNode, property: isMusic)
        } else if node.name == "sound" {
            isSound = !isSound
            update(node: node as! SKSpriteNode, property: isSound)
        } else if node.name == "back" {
            
            gameSettings.isSound = isSound
            gameSettings.isMusic = isMusic
            gameSettings.saveGameSettings()
            
            makeTheTransition(to: backScene, handler: nil)
        }
    }
    
    private func update(node: SKSpriteNode, property: Bool) {
        if let name = node.name {
            node.texture = property ? SKTexture(imageNamed: name) : SKTexture(imageNamed: "no" + name)
        }
    }
}


