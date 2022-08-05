//
//  GameScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 03.08.2022.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    
    private var player: SKSpriteNode?
    
    let screen = UIScreen.main.bounds //определили размер экрана
    
    override func didMove(to view: SKView) {
        self.configureStartScene()
        self.spawnClouds()
        self.spawnIsland()
    }
    
    private func spawnClouds() {
        //создаем 2 action: 1 - интервал когда ничего происходить не будет, 2 - генерация нашего объекта
        let spawnCloudWait = SKAction.wait(forDuration: 1)
        let spawnCloudAction = SKAction.run {
            let cloud = Cloud.populate()
            self.addChild(cloud)
        }
        let spawnCloydSequence = SKAction.sequence([spawnCloudWait, spawnCloudAction])
        let spawnCloudForever = SKAction.repeatForever(spawnCloydSequence) //бесконечно генерируем облака каждую секунду
        run(spawnCloudForever)
    }
    
    private func spawnIsland() {
        //создаем 2 action: 1 - интервал когда ничего происходить не будет, 2 - генерация нашего объекта
        let spawnIslandWait = SKAction.wait(forDuration: 2)
        let spawnIslandAction = SKAction.run {
            let island = Island.populate()
            self.addChild(island)
        }
        let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence) //бесконечно генерируем острова каждые 2 секунды
        run(spawnIslandForever)
    }
    
    private func configureStartScene() {
        
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        let island1 = Island.populate(at: CGPoint(x: 100, y: 200))
        self.addChild(island1)
        
        let island2 = Island.populate(at: CGPoint(x: self.size.width - 100, y: self.size.height - 200))
        self.addChild(island2)
        
        let cloud1 = Cloud.populate(at: CGPoint(x: 300, y: 200))
        self.addChild(cloud1)
        
        let cloud2 = Cloud.populate(at: CGPoint(x: self.size.width - 200, y: self.size.height - 50))
        self.addChild(cloud2)
        
        
        self.player = PlayerPlane.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        
        self.addChild(player ?? SKSpriteNode())
        
        self.motionManager.accelerometerUpdateInterval = 0.2 //замеряет ускорения каждые 0.2 сек
        self.motionManager.startAccelerometerUpdates(to: OperationQueue.current ?? OperationQueue()) { data, error in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
    
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        guard let player = player else {
            return
        }
        
        player.position.x += xAcceleration * 50 //перемещаем самолет
        
        if player.position.x < -70 {
            player.position.x = self.size.width + 70
        } else if player.position.x > self.size.width + 70 {
            player.position.x = -70
        }
    }
}

