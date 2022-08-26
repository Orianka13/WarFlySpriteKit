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
    // создаем облако
    static func populate(at point: CGPoint?) -> Cloud {
        let cloudName = configureCloudName()
        let cloud = Cloud(imageNamed: cloudName)
        cloud.setScale(randomScaleFactor)
        cloud.position = point ?? randomPoint()
        cloud.zPosition = randomZPosition
        cloud.name = "sprite"
        //cloud.anchorPoint = CGPoint(x: 0.5, y: 1.0) //перемещаем границу вверх чтобы удаление объектов происходило после пересечения верхней границы объекта
        cloud.run(move(from: cloud.position))
        return cloud
    }
    
    //генерируем рандомное расположение
    private static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 10, highestValue: 20)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    //генерируем рандомное имя
    private static func configureCloudName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        let randomName = "cl" + String(distribution.nextInt())
        return randomName
    }
    
    //генерируем рандомную zPosition для облаков, чтобы некоторые были над и некоторые под самолетом
    private static var randomZPosition: CGFloat  {
        let distribution = GKRandomDistribution(lowestValue: 18, highestValue: 22)
        let randomNumber = CGFloat(distribution.nextInt())
        
        return randomNumber
    }
    
    //добавим движение облаков по вертикали вниз
    private static func move(from point: CGPoint) -> SKAction {
    
        let movePoint = CGPoint(x: point.x, y: -200) //при движении строго вниз координата х не меняется
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 150.0
        let duration = moveDistance / movementSpeed
        
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}