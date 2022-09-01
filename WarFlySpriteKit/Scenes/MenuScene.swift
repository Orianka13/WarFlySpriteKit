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
        
        setHeader(withName: nil, andBackground: "header1")
        
        let titles = ["play", "options", "best"]
        
        setMenuButtons(withTitle: titles)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        let node = self.atPoint(location)
        
        if node.name == "play" { 
            makeTheTransition(to: GameScene(size: self.size), handler: nil)
            
        } else if node.name == "options" {
            makeTheTransition(to: OptionsScene(size: self.size)) { scene in
                scene.backScene = self
            }
            
        } else if node.name == "best" {
            makeTheTransition(to: BestScene(size: self.size)) { scene in
                scene.backScene = self
            }
        }
    }
}
