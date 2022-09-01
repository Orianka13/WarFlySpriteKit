//
//  Cloud.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 03.08.2022.
//

import UIKit
import SpriteKit
import GameplayKit


final class Cloud: SKSpriteNode, GameBackgroundSpritable {

    static func populate(at point: CGPoint?) -> Cloud {
        let cloudName = configureCloudName()
        let cloud = Cloud(imageNamed: cloudName)
        cloud.setScale(randomScaleFactor)
        cloud.position = point ?? randomPoint()
        cloud.zPosition = randomZPosition
        cloud.name = "sprite"
        //cloud.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        cloud.run(move(from: cloud.position))
        return cloud
    }
    
    private static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    private static func configureCloudName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        let randomName = "cl" + String(distribution.nextInt())
        return randomName
    }
    
    private static var randomZPosition: CGFloat  {
        let distribution = GKRandomDistribution(lowestValue: 18, highestValue: 22)
        let randomNumber = CGFloat(distribution.nextInt())
        
        return randomNumber
    }
    
    private static func move(from point: CGPoint) -> SKAction {
    
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 150.0
        let duration = moveDistance / movementSpeed
        
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
