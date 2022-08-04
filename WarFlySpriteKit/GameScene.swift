//
//  GameScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 03.08.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        let screen = UIScreen.main.bounds //определили размер экрана
        for _ in 1...5 {
            //определяем размеры экрана в пределах которого будут генериться острова
            let x: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
            let y: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.height)))
            
            let island = Island.populateSprite(at: CGPoint(x: x, y: y))
            self.addChild(island)
            
            let x1: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
            let y1: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.height)))
            
            let cloud = Cloud.populateSprite(at: CGPoint(x: x1, y: y1))
            self.addChild(cloud)
        }
    }
}

