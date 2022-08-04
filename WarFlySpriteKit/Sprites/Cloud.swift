//
//  Cloud.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 03.08.2022.
//

import UIKit
import SpriteKit
import GameplayKit

protocol GameBackgroundSpritable {
    static func populateSprite(at point: CGPoint) -> Self // Self - означает что должен быть возвращен либо тип протокола, либо тип класса, который подписан под этот протокол - у класса поставить final
    
}

final class Cloud: SKSpriteNode, GameBackgroundSpritable {
    // создаем облако
    static func populateSprite(at point: CGPoint) -> Cloud {
        let cloudName = configureCloudName()
        let cloud = Cloud(imageNamed: cloudName)
        cloud.setScale(randomScaleFactor)
        cloud.position = point
        cloud.zPosition = 10
        cloud.run(move(from: point))
        return cloud
    }
    
    //генерируем рандомное расположение
    private static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 20, highestValue: 30)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    //генерируем рандомное имя
    private static func configureCloudName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        let randomName = "cl" + String(distribution.nextInt())
        return randomName
    }
    
    //добавим движение облаков по вертикали вниз
    private static func move(from point: CGPoint) -> SKAction {
    
        let movePoint = CGPoint(x: point.x, y: -200) //при движении строго вниз координата х не меняется
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 15.0
        let duration = moveDistance / movementSpeed
        
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
