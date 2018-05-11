//
//  Player.swift
//  MonopolyAR
//
//  Created by Никита Солдатов on 07.05.2018.
//  Copyright © 2018 ru.itis.iosLab. All rights reserved.
//

import Foundation
import SceneKit

class Player: Equatable {
    var id: Int
    var name: String
    var object: PlayerObject & SCNNode
    var turnNumber = 0
    var funds: Double = 1500 {
        didSet {
            object.updateMoney(with: funds)
            onMoneyChange?(oldValue, funds, self)
        }
    }
    //var playerHasFreeCard: [Card] = []
    var onMoneyChange: ((_ oldValue: Double, _ actual: Double, _ player: Player) -> Void)?
    
    init(id: Int, name: String, object: PlayerObject & SCNNode) {
        self.id = id
        self.name = name
        self.object = object
        object.updateMoney(with: funds)
    }
    
    var currentSpace: SpaceProtocol! {
        didSet {
            object.position = currentSpace.node.position
            currentSpace.whenPlayerOnSpace(self) // Perform space action
        }
    }
    var playerInJail: Bool = false 

    func removeMoney(amount: Double) {
        if funds < amount {

        } else {
            funds -= amount
        }
    }
    
    func addMoney(amount: Double) {
        funds += amount
    }
    
    func onTurn() {
    }
    
    /// Make Player Equatable
    ///
    /// Needed to differentiate between community chest and chance spaces
    /// - Warning: Do not use directly
    /// - Parameter lhs: Left side of function
    /// - Parameter rhs: Right side of function
    /// - Returns: Boolean - Whether IDs are equal
    static func == (lhs: Player, rhs: Player) -> Bool { // Player
        var isEqual = false
        if lhs.id == rhs.id {
            isEqual = true
        }
        return isEqual
    }
}
