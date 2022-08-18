//
//  PlayerPlane.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 04.08.2022.
//

import SpriteKit
import CoreMotion

class PlayerPlane: SKSpriteNode {
    
    private enum TurnDirection {
        case left
        case right
        case none
    }
    
    private let motionManager = CMMotionManager()
    private var xAcceleration: CGFloat = 0
    
    private var leftTextureArrayAnimation = [SKTexture]()
    private var rightTextureArrayAnimation = [SKTexture]()
    private var forwardTextureArrayAnimation = [SKTexture]()
    
    private var moveDirection: TurnDirection = .none
    private var stillTurning = false
    
    private let strides = [(13, 1, -1), (13, 26, 1), (13, 13, 1)]
    
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    

    static func populate(at point: CGPoint) -> PlayerPlane {
        let atlas = Assets.shared.playerPlaneAtlas
        let playerPlaneTexture = atlas.textureNamed("airplane_3ver2_13")
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.5)
        playerPlane.position = point
        playerPlane.zPosition = 40
        
        playerPlane.physicsBody = SKPhysicsBody(texture: playerPlaneTexture,
                                                alphaThreshold: 0.5,
                                                size: playerPlane.size) //создали физическое тело объекта
        playerPlane.physicsBody?.isDynamic = false //если в нас кто то влетит-мы не отскочим, статичны
        playerPlane.physicsBody?.categoryBitMask = BitMaskCategory.player.rawValue //присвоили битовую маску
        playerPlane.physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue | BitMaskCategory.powerUp.rawValue //битовые маски с которыми игрок сталкивается
        playerPlane.physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue | BitMaskCategory.powerUp.rawValue
        
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
        
        self.preloadTextureArrays()
        
        self.motionManager.accelerometerUpdateInterval = 0.2 //замеряет ускорения каждые 0.2 сек
        self.motionManager.startAccelerometerUpdates(to: OperationQueue.current ?? OperationQueue()) { [weak self] data, error in
            if let data = data {
                let acceleration = data.acceleration
                self?.xAcceleration = CGFloat(acceleration.x) * 0.7 + (self?.xAcceleration ?? 0.0) * 0.3
            }
        }
        
        //вызовем метод movementDirectionCheck() раз в секунду
        let planeWaitAction = SKAction.wait(forDuration: 1.0)
        
        let planeDirectionCheckAction = SKAction.run { [weak self] in
            self?.movementDirectionCheck()
        }
        
        let sequence = SKAction.sequence([planeWaitAction, planeDirectionCheckAction])
        let playSequenceForever = SKAction.repeatForever(sequence)
        self.run(playSequenceForever)
    }
    
    
    //определим какой массив текстур нужно использовать:
    private func movementDirectionCheck() {
        if self.xAcceleration > 0.02, self.moveDirection != .right, self.stillTurning == false {
            self.stillTurning = true
            self.moveDirection = .right
            self.turnPlane(direction: .right)
        } else if self.xAcceleration < -0.02, self.moveDirection != .left, self.stillTurning == false {
            self.stillTurning = true
            self.moveDirection = .left
            self.turnPlane(direction: .left)
        } else if self.stillTurning == false {
            self.moveDirection = .none
            self.turnPlane(direction: .none)
        }
    }
    
    //метод отвечающий за анимацию поворотов
    private func turnPlane(direction: TurnDirection) {
        //создадим массив и заполним его в зависимости от флага поворота
        var array = [SKTexture]()
        
        if direction == .right {
            array = rightTextureArrayAnimation
        } else if direction == .left {
            array = leftTextureArrayAnimation
        } else {
            array = forwardTextureArrayAnimation
        }
        
        //создаем 2 action: поворот в одну сторону и возврат в ровное положение
        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.05, resize: true, restore: false) //resize - изменяется размер в зависимоти от размера текстур на экране, restore - возврат к первому кадру анимации
        let backwardAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.05, resize: true, restore: false)
        
        let sequenceAction = SKAction.sequence([forwardAction, backwardAction])
        
        self.run(sequenceAction) { [weak self] in
            self?.stillTurning = false
        }
    }
    
    //метод в котором перебираем все изображения и помещаем в различные массивы
    private func preloadTextureArrays() {
        for i in 0...2 {
            self.fillTextureArray(_strides: self.strides[i]) { [weak self] array in
                switch i {
                case 0:
                    self?.leftTextureArrayAnimation = array
                case 1:
                    self?.rightTextureArrayAnimation = array
                case 2:
                    self?.forwardTextureArrayAnimation = array
                default:
                    break
                }
            }
        }
    }
    
    private func fillTextureArray(_strides: (Int, Int, Int), callback: @escaping (_ array: [SKTexture]) -> Void) {
        var array = [SKTexture]()
        for i in stride(from: _strides.0, through: _strides.1 , by: _strides.2) {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
            array.append(texture)
        }
        SKTexture.preload(array) {
            callback(array)
        }
    }
    
}
