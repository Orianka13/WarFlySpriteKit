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
        self.spawnEnemies()
    }
    
    private func spawnPowerUp() {
        let spawnAction = SKAction.run { [weak self] in
            let randomNumber = Int(arc4random_uniform(2))
            let powerUp = randomNumber == 1 ? BluePowerUp() : GreenPowerUp()
            let randomPositionX = arc4random_uniform(UInt32((self?.size.width ?? 0) - 30))
            
            powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: (self?.size.height ?? 0) + 100)
            powerUp.startMovement()
            
            self?.addChild(powerUp)
        }
        
        let randomTimeSpawn = Double(arc4random_uniform(11) + 10)
        let waitAction = SKAction.wait(forDuration: randomTimeSpawn)
        
        let sequense = SKAction.sequence([spawnAction, waitAction])
        self.run(SKAction.repeatForever(sequense))
        
    }
    
    private func spawnEnemies() {
        let waitAction = SKAction.wait(forDuration: 3.0)
        let spawnSpiralAction = SKAction.run { [weak self] in
            self?.spawnSpiralOfEnemies()
        }
        let sequense = SKAction.sequence([spawnSpiralAction, waitAction])
        self.run(SKAction.repeatForever(sequense))
    }
    
    private func spawnSpiralOfEnemies() {
        let enemyTextureAtlas1 = SKTextureAtlas(named: "Enemy_1")
        let enemyTextureAtlas2 = SKTextureAtlas(named: "Enemy_2")
        
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) { [weak self] in
            
            let randomNumber = Int(arc4random_uniform(2))
            let arrayOfAtlases = [enemyTextureAtlas1, enemyTextureAtlas2]
            let textureAtlas = arrayOfAtlases[randomNumber]
            
            let waitAction = SKAction.wait(forDuration: 1.0)
            let spawnEnemy = SKAction.run { [ weak self] in
                
                let textureNames = textureAtlas.textureNames.sorted()
                let textureName = textureNames[12] //вернули массив имен в атласе чтобы взять 12-ый элемент
                
                let enemy = Enemy(enemyTexture: textureAtlas.textureNamed(textureName))
                enemy.position = CGPoint(x: (self?.size.width ?? 0) / 2, y: (self?.size.height ?? 0) + 110)
                self?.addChild(enemy)
                enemy.flySpiral()
            }
            let spawnAction = SKAction.sequence([spawnEnemy, waitAction])
            
            let randomCountOfEnemies = Int(arc4random_uniform(5))
            let repeatAction = SKAction.repeat(spawnAction, count: randomCountOfEnemies)
            self?.run(repeatAction)
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
            if node.position.y <= -100 { //если нод внизу за пределами экрана
                node.removeFromParent() //удаляем ее с экрана
                if node.isKind(of: PowerUp.self) {
                    print("PowerUp is removed from scene")
                }
            }
        }
    }
}

