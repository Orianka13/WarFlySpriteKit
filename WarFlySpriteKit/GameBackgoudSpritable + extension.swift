//
//  GameBackgoudSpriteable + extension.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 05.08.2022.
//

import SpriteKit
import GameplayKit


protocol GameBackgroundSpritable {
    static func populate(at point: CGPoint?) -> Self // Self - означает что должен быть возвращен либо тип протокола, либо тип класса, который подписан под этот протокол - у класса поставить final
    static func randomPoint() -> CGPoint
}


extension GameBackgroundSpritable {
    //сгенерируем точку от 100 до 200 выше экрана (для генерации островов и облаков ЗА пределами экрана)
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 100, highestValue: Int(screen.size.height) + 200)
        let y = CGFloat(distribution.nextInt()) //nextInt() - используется для генерации значений
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        
        return CGPoint(x: x, y: y)
    }
}
