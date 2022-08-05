//
//  PlayerPlane.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 04.08.2022.
//

import SpriteKit
import CoreMotion

class PlayerPlane: SKSpriteNode {
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    

    static func populate(at point: CGPoint) -> PlayerPlane {
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13") //текстура меняться может а изображение нет (к текстуре можем применить покадровую анимацию)
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 20
        
        return playerPlane
    }
    
    func checkPosition() {
        
        self.position.x += xAcceleration * 50 //перемещаем самолет
        
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    
    func performFly() {
        self.motionManager.accelerometerUpdateInterval = 0.2 //замеряет ускорения каждые 0.2 сек
        self.motionManager.startAccelerometerUpdates(to: OperationQueue.current ?? OperationQueue()) { data, error in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
    
}
