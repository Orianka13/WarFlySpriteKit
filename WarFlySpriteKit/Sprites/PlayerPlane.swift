//
//  PlayerPlane.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 04.08.2022.
//

import SpriteKit
import CoreMotion

class PlayerPlane: SKSpriteNode {
    
    private let motionManager = CMMotionManager()
    private var xAcceleration: CGFloat = 0
    
    private var leftTextureArrayAnimation = [SKTexture]()
    private var rightTextureArrayAnimation = [SKTexture]()
    private var forwardTextureArrayAnimation = [SKTexture]()
    
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
        
        self.planeAnimationFillArray()
        
        self.motionManager.accelerometerUpdateInterval = 0.2 //замеряет ускорения каждые 0.2 сек
        self.motionManager.startAccelerometerUpdates(to: OperationQueue.current ?? OperationQueue()) { data, error in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
    
    //метод в котором перебираем все изображения и помещаем в различные массивы
    private func planeAnimationFillArray() {
        //подгрузим атлас
        SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "PlayerPlane")]) {
            self.leftTextureArrayAnimation = {
                var array = [SKTexture]()
                for i in stride(from: 13, through: 1, by: -1){
                    let number = String(format: "%02d", i)
                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
                    array.append(texture)
                }
                SKTexture.preload(array) {
                    print("preload is done")
                }
                return array
            }()
            
            self.rightTextureArrayAnimation = {
                var array = [SKTexture]()
                for i in stride(from: 13, through: 26, by: 1){
                    let number = String(format: "%02d", i)
                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
                    array.append(texture)
                }
                SKTexture.preload(array) {
                    print("preload is done")
                }
                return array
            }()
            
            self.forwardTextureArrayAnimation = {
                var array = [SKTexture]()
                let texture = SKTexture(imageNamed: "airplane_3ver2_13")
                
                array.append(texture)
                
                SKTexture.preload(array) {
                    print("preload is done")
                }
                return array
            }()
        }
    }
    
}
