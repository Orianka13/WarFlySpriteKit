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
    private let scoreBackground = SKSpriteNode(imageNamed: "scores")
    private let scoreLabel = SKLabelNode(text: "10 000")
    private let menuButton = SKSpriteNode(imageNamed: "menu")
    private let life1 = SKSpriteNode(imageNamed: "life")
    private let life2 = SKSpriteNode(imageNamed: "life")
    private let life3 = SKSpriteNode(imageNamed: "life")
    
    let screen = UIScreen.main.bounds //определили размер экрана
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        self.configureStartScene()
        self.spawnClouds()
        self.spawnIsland()
        
        self.player?.performFly()
        
        self.spawnPowerUp()
        self.spawnEnemies()
        self.configureUI()
    }
    
    private func configureUI() {
        self.scoreBackground.position = CGPoint(x: scoreBackground.size.width + 10,
                                                y: self.view?.safeAreaLayoutGuide.layoutFrame.size.height ?? 0)
        self.scoreBackground.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        self.scoreBackground.zPosition = 99
        self.addChild(scoreBackground)
        
        self.scoreLabel.horizontalAlignmentMode = .right
        self.scoreLabel.verticalAlignmentMode = .center
        self.scoreLabel.position = CGPoint(x: -10, y: 3)
        self.scoreLabel.zPosition = 100
        self.scoreLabel.fontName = "AmericanTypewriter-Bold"
        self.scoreLabel.fontSize = 30
        self.scoreBackground.addChild(scoreLabel)
        
        self.menuButton.position = CGPoint(x: 20, y: 20)
        self.menuButton.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        self.menuButton.zPosition = 100
        self.addChild(menuButton)
        
        let lifes = [life1, life2, life3]
        for (index, life) in lifes.enumerated() {
            life.position = CGPoint(x: self.size.width - CGFloat(index + 1) * life.size.width + 3,
                                    y: 20)
            life.zPosition = 100
            life.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            self.addChild(life)
            
        }
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
        let enemyTextureAtlas1 = Assets.shared.enemy_1Atlas
        let enemyTextureAtlas2 = Assets.shared.enemy_2Atlas
        
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
            }
        }
        
        enumerateChildNodes(withName: "shotSprite") { node, stop in
            if node.position.y >= self.size.height + 20 {
                node.removeFromParent()
            }
        }
    }
    
    private func playerFire() {
        let shot = YellowShot()
        shot.position = self.player?.position ?? CGPoint()
        shot.startMovement()
        self.addChild(shot)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.playerFire()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        
        switch contactCategory {
        case [.enemy, .player]:
            print("player VS enemy")
        case [.player, .powerUp]:
            print("player VS powerUp")
        case [.enemy, .shot]:
            print("enemy VS shot")
        default:
            preconditionFailure("Unable to detect collision category")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
