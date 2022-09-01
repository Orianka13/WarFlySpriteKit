//
//  GameScene.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 03.08.2022.
//

import SpriteKit
import GameplayKit


class GameScene: ParentScene {
    
    private var backgroundMusic: SKAudioNode!
    
    private var player: PlayerPlane?
    private let hud = HUD()
    private var score = 0 {
        didSet {
            hud.scoreLabel.text = "\(score)"
        }
    }
    private var lives = 3 {
        didSet {
            switch lives {
            case 3:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = false
            case 2:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = true
            case 1:
                hud.life1.isHidden = false
                hud.life2.isHidden = true
                hud.life3.isHidden = true
            default:
                break
            }
        }
    }
    
    private let screenSize = UIScreen.main.bounds.size
    
    private let screen = UIScreen.main.bounds //определили размер экрана
    
    override func didMove(to view: SKView) {
        
        gameSettings.loadGameSettings()
        
        if gameSettings.isMusic {
            if let musicURL = Bundle.main.url(forResource: "backgroundMusic", withExtension: "m4a") { // проверяем есть ли файл с музыкой в проекте
                self.backgroundMusic = SKAudioNode(url: musicURL) //создаем аудио нод
                addChild(backgroundMusic) //вызываем его
            }
        }
        
        self.scene?.isPaused = false
        
        //проверим существует ли gameScene
        guard sceneManager.gameScene == nil else { return }
        sceneManager.gameScene = self
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        self.configureStartScene()
        self.spawnClouds()
        self.spawnIsland()
        
        self.player?.performFly()
        
        self.spawnPowerUp()
        self.spawnEnemies()
        
        self.addChild(hud)
        self.hud.configureUI(screenSize: self.screenSize, layotSize: view.safeAreaLayoutGuide.layoutFrame.size)
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
        enumerateChildNodes(withName: "bluePowerUp") { node, stop in
            if node.position.y <= -50 {
                node.removeFromParent()
            }
        }
        enumerateChildNodes(withName: "greenPowerUp") { node, stop in
            if node.position.y <= -50 {
                node.removeFromParent()
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
        guard let location = touches.first?.location(in: self) else { return }
        let node = self.atPoint(location)
        
        if node.name == "pause" {
            
            let transition = SKTransition.doorway(withDuration: 1)
            let pauseScene = PauseScene(size: self.size)
            pauseScene.scaleMode = .aspectFill
            
            self.sceneManager.gameScene = self//сохраняем состояние сцены в менеджер чтобы потом ее оттуда загрузить
            self.scene?.isPaused = true //ставим сцену на паузу
            
            self.scene?.view?.presentScene(pauseScene, transition: transition)
        } else {
            self.playerFire()
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let explosion = SKEmitterNode(fileNamed: "EnemyExplosion")
        let contactPoint = contact.contactPoint
        explosion?.position = contactPoint
        explosion?.zPosition = 25
        let waitForExplosionAction = SKAction.wait(forDuration: 1)
        
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        
        switch contactCategory {
        case [.enemy, .player]:
            print("player VS enemy")
            if contact.bodyA.node?.name == "sprite" {
                if contact.bodyA.node?.parent != nil {
                    contact.bodyA.node?.removeFromParent()
                    
                    if gameSettings.isSound {
                        self.run(SKAction.playSoundFileNamed("enemyCrashSound", waitForCompletion: false))
                    }
                  
                    self.lives -= 1
                }
            } else {
                if contact.bodyB.node?.parent != nil {
                    contact.bodyB.node?.removeFromParent()
                    if gameSettings.isSound {
                    self.run(SKAction.playSoundFileNamed("enemyCrashSound", waitForCompletion: false))
                    }
                    self.lives -= 1
                }
            }
            guard let explosion = explosion else { return }
            addChild(explosion)
            self.run(waitForExplosionAction) { explosion.removeFromParent() }
            
            if self.lives == 0 {
                gameSettings.currentScore = self.score
                gameSettings.saveScores()
                makeTheTransition(to: GameOverScene(size: self.size), handler: nil)
            }
            
        case [.player, .powerUp]:
            print("player VS powerUp")
            
            if contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil {
                if contact.bodyA.node?.name == "bluePowerUp" {
                    contact.bodyA.node?.removeFromParent()
                    if gameSettings.isSound {
                    self.run(SKAction.playSoundFileNamed("powerUpSound", waitForCompletion: false))
                    }
                    self.lives = 3
                    player?.run(player?.livesBlueBoostAnimation() ?? SKAction())
                } else if contact.bodyB.node?.name == "bluePowerUp" {
                    contact.bodyB.node?.removeFromParent()
                    if gameSettings.isSound {
                    self.run(SKAction.playSoundFileNamed("powerUpSound", waitForCompletion: false))
                    }
                    self.lives = 3
                    player?.run(player?.livesBlueBoostAnimation() ?? SKAction())
                }
                if contact.bodyA.node?.name == "greenPowerUp" {
                    contact.bodyA.node?.removeFromParent()
                    if gameSettings.isSound {
                    self.run(SKAction.playSoundFileNamed("powerUpSound", waitForCompletion: false))
                    }
                    if self.lives < 3 {
                        self.lives += 1
                    }
                    player?.run(player?.livesGreenBoostAnimation() ?? SKAction())
                } else if contact.bodyB.node?.name == "greenPowerUp" {
                    contact.bodyB.node?.removeFromParent()
                    if gameSettings.isSound {
                    self.run(SKAction.playSoundFileNamed("powerUpSound", waitForCompletion: false))
                    }
                    if self.lives < 3 {
                        self.lives += 1
                    }
                    player?.run(player?.livesGreenBoostAnimation() ?? SKAction())
                }
            }
        case [.enemy, .shot]:
            print("enemy VS shot")
            if contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil {
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                if gameSettings.isSound {
                self.run(SKAction.playSoundFileNamed("hitSound", waitForCompletion: false))
                }
                self.score += 1
                guard let explosion = explosion else { return }
                addChild(explosion)
                self.run(waitForExplosionAction) { explosion.removeFromParent() }
            }
        default:
            preconditionFailure("Unable to detect collision category")
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
    }
}
