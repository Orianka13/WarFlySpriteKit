//
//  BitMaskCategory.swift
//  WarFlySpriteKit
//
//  Created by Олеся Егорова on 17.08.2022.
//

import Foundation

struct BitMaskCategory {
    static let player: UInt32 = 0x1 << 0 // 00000000...1
    static let enemy: UInt32 = 0x1 << 1 // 0000000...10
    static let powerUp: UInt32 = 0x1 << 2 // 000000...100
    static let shot: UInt32 = 0x1 << 3
}
