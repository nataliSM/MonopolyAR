//
//  Card.swift
//  MonopolyAR
//
//  Created by Никита Солдатов on 07.05.2018.
//  Copyright © 2018 ru.itis.iosLab. All rights reserved.
//

import Foundation

/// A Chance or Community Chest card
class Card {
    /// Choice of Chance or Community Chest cards
    enum format {
        case communityChest
        case chance
    }
    
    /// Select a card within an array randomly
    /// - SeeAlso: chanceCards communityChestCards
    /// - Parameter type: Card.format either .chance or .communityChest
    static func drawCard(type: format) {
        switch type {
        case .chance:
            break
        // chanceCards
        case .communityChest:
            break
            // communityChestCards
        }
    }
}
