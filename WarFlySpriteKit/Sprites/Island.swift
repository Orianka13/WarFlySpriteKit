//
//  Island.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 03.08.2022.
//

import UIKit
import SpriteKit
import GameplayKit // импортируем для генерации рандомных чисел

final class Island: SKSpriteNode, GameBackgroundSpritable {
    
    // создаем остров
    static func populateSprite(at point: CGPoint) -> Island {
        let islandName = configureIslandName()
        let island = Island(imageNamed: islandName)
        island.setScale(randomScaleFactor)
        island.position = point
        island.zPosition = 1
        island.run(rotateForRandomAngle())
        island.run(move(from: point))
        return island
    }
    
    //генерируем рандомное расположение
    private static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    //генерируем рандомное имя
    private static func configureIslandName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 4)
        let randomName = "is" + String(distribution.nextInt())
        return randomName
    }
    
    //генерируем рандомный угол поворота
    private static func rotateForRandomAngle() -> SKAction {
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
        let randomNumber = CGFloat(distribution.nextInt())
        
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0) //вычисляем радианы
    }
    
    //добавим движение островов по вертикали вниз
    private static func move(from point: CGPoint) -> SKAction {
    
        let movePoint = CGPoint(x: point.x, y: -200) //при движении строго вниз координата х не меняется
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 10.0
        let duration = moveDistance / movementSpeed
        
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
