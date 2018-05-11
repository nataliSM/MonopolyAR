//
//  Card.swift
//  MonopolyAR
//
//  Created by Никита Солдатов on 07.05.2018.
//  Copyright © 2018 ru.itis.iosLab. All rights reserved.
//

import Foundation

/// A Chance or Community Chest card
class Chance {
    enum Action {
        case tax(Double)
        case prize(Double)
        case move(to: SpaceProtocol)
        case take(from: [Player], price: Double)
        case give(to: [Player], price: Double)
    }
    
    let name: String
    let action: Action
    let description: String
    
    init(name: String, description: String, action: Action) {
        self.name = name
        self.description = description
        self.action = action
    }
    
    func apply(for player: Player) {
        switch action {
        case .tax(let price):
            player.removeMoney(amount: price)
        case .prize(let price):
            player.addMoney(amount: price)
        default:
            return
        }
    }
}

class CommunityChest {
    
}

