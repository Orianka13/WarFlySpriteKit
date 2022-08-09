//
//  GameScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 03.08.2022.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    private var player: PlayerPlane?
    
    let screen = UIScreen.main.bounds //определили размер экрана
    
    override func didMove(to view: SKView) {
        self.configureStartScene()
        self.spawnClouds()
        self.spawnIsland()
        
        let deadline = DispatchTime.now() + .nanoseconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadline) { [weak self] in
            self?.player?.performFly()
        }
        
        self.spawnPowerUp()
        self.spawnEnemy(count: 5)
    }
    
    private func spawnPowerUp() {
        let powerUp = PowerUp()
        powerUp.performRotation()
        powerUp.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(powerUp)
    }
    
    private func spawnEnemy(count: Int) {
        let enemyTextureAtlas = SKTextureAtlas(named: "Enemy_1")
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas]) {
            Enemy.textureAtlas = enemyTextureAtlas
            let waitAction = SKAction.wait(forDuration: 1.0)
            let spawnEnemy = SKAction.run {
                let enemy = Enemy()
                enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 110)
                self.addChild(enemy)
                enemy.flySpiral()
            }
            let spawnAction = SKAction.sequence([spawnEnemy, waitAction])
            let repeatAction = SKAction.repeat(spawnAction, count: count)
            self.run(repeatAction)
        }
        
    }
    
    private func spawnClouds() {
        //создаем 2 action: 1 - интервал когда ничего происходить не будет, 2 - генерация нашего объекта
        let spawnCloudWait = SKAction.wait(forDuration: 1)
        let spawnCloudAction = SKAction.run {
            let cloud = Cloud.populate(at: nil)
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
            let island = Island.populate(at: nil)
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
        
        
    }
    
    override func didSimulatePhysics() {
        guard let player = player else {
            return
        }
        
        player.checkPosition()
        
        enumerateChildNodes(withName: "sprite") { node, stop in
            if node.position.y < -100 { //если нод внизу за пределами экрана
                node.removeFromParent() //удаляем ее с экрана
            }
        }
    }
}

