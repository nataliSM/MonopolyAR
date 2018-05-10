//
//  Monopoly.swift
//  MonopolyAR
//
//  Created by Никита Солдатов on 07.05.2018.
//  Copyright © 2018 ru.itis.iosLab. All rights reserved.
//

import Foundation
import SceneKit
typealias DiceResult = (die1: Int, die2: Int)
/**
 Array to hold all spaces on the board
 */
protocol MonopolyDelegate: class {
    func diceThrowResult(_ result: DiceResult, for player: Player)
    func playerBalanceDidChange(_ player: Player, balance: Double)
    func playerDidBuyProperty(_ player: Player, property: PropertySpace)
    func playerDidStepOnOwnedSpace(_ player: Player, ownedSpace: OwnedSpaceProtocol)
}

class Monopoly {
    
    var map: [SpaceProtocol] = []
    var mapNode: SCNNode
    weak var delegate: MonopolyDelegate?
    init(players: [Player], mapNode: SCNNode) {
        self.players = players
        self.activePlayer = players[0]
        self.mapNode = mapNode
        self.map = buildMap()
        players.forEach { (player) in
            player.currentSpace = map[0]
        }
    }
    
    func buildMap() -> [SpaceProtocol] {
        let map: [SpaceProtocol] = [
            actionSpace(name: .space_start, action: .start(price: endRound)),
            propertySpace(name: .property_brown_1),
            actionSpace(name: .space_cmn_chest_1, action: .communityChest),
            propertySpace(name: .property_brown_2),
            actionSpace(name: .space_income_tax_1, action: .tax(price: incomeTax)),
            trainStationSpace(name: .owned_space_reading_railroad),
            propertySpace(name: .property_light_blue_1),
            actionSpace(name: .space_chance_1, action: .chance),
            propertySpace(name: .property_light_blue_2),
            propertySpace(name: .property_light_blue_3),
            actionSpace(name: .space_jail, action: .none),
            propertySpace(name: .property_pink_1),
            comunalSpace(name: .owned_space_electricity),
            propertySpace(name: .property_pink_2),
            propertySpace(name: .property_pink_3),
            trainStationSpace(name: .owned_space_pensyllvania_railroad),
            propertySpace(name: .property_orange_1),
            propertySpace(name: .property_orange_2),
            actionSpace(name: .space_cmn_chest_2, action: .communityChest),
            propertySpace(name: .property_orange_3),
            actionSpace(name: .space_free_parking, action: .none),
            propertySpace(name: .property_red_1),
            actionSpace(name: .space_chance_2, action: .chance),
            propertySpace(name: .property_red_2),
            propertySpace(name: .property_red_3),
            trainStationSpace(name: .owned_space_bo_railroad),
            propertySpace(name: .property_yellow_1),
            propertySpace(name: .property_yellow_2),
            comunalSpace(name: .owned_space_water_works),
            propertySpace(name: .property_yellow_3),
            actionSpace(name: .smace_go_to_jail, action: .toJail),
            propertySpace(name: .property_green_1),
            propertySpace(name: .property_green_2),
            actionSpace(name: .space_cmn_chest_3, action: .communityChest),
            propertySpace(name: .property_green_3),
            trainStationSpace(name: .owned_space_short_line),
            actionSpace(name: .space_chnce_3, action: .chance),
            propertySpace(name: .property_blue_1),
            actionSpace(name: .space_luxary_tax, action: .tax(price: luxaryTax)),
            propertySpace(name: .property_blue_2)
        ]
        return map
    }
    
    private func actionSpace(name: NodeName, action: ActionSpace.Action) -> ActionSpace {
        var node = self.node(name: name)
        if case .communityChest = action {
            let placeIcon = node.childNode(withName: "place_icon", recursively: true)!
            let chest = Chest()
            mapNode.addChildNode(chest.node)
            let rotateAction = SCNAction.rotate(by: CGFloat.pi * 2, around: SCNVector3(0, 0, 1), duration: 10.0)
            chest.node.runAction(SCNAction.repeatForever(rotateAction))
            chest.node.worldPosition = placeIcon.worldPosition
            print(chest.node.worldPosition)
            print(chest.node.position)
        }
        return ActionSpace(nodeName: name, node: node, action: action)
    }
    
    private func trainStationSpace(name: NodeName) -> TrainStationSpace {
        let space = TrainStationSpace(ownershipPolicy: policy(name: name), node: node(name: name), nodeName: name)
        space.stepOnEmty = { [weak self] place, player in 
            self?.delegate?.playerDidStepOnOwnedSpace(player, ownedSpace: place)
        }
        
        return space
    }
    
    private func comunalSpace(name: NodeName) -> ComunalSpace {
        let space = ComunalSpace(ownershipPolicy: policy(name: name), node: node(name: name), nodeName: name)
        space.stepOnEmty = { [weak self] place, player in 
            self?.delegate?.playerDidStepOnOwnedSpace(player, ownedSpace: place)
        }
        
        return space
    }
    
    private func propertySpace(name: NodeName) -> PropertySpace {
        let space = PropertySpace(ownershipPolicy: policy(name: name), node: node(name: name), nodeName: name)
        space.stepOnEmty = { [weak self] place, player in 
            self?.delegate?.playerDidStepOnOwnedSpace(player, ownedSpace: place)
        }
        
        return space
    }
    
    private func policy(name: NodeName) -> Policy {
   
        return Policy(price: 200, tax: 20)
    }
    
    private func node(name: NodeName) -> SCNNode {
        let startNode = mapNode.childNode(withName: name.rawValue, recursively: true)!
        return startNode
    }
    
    var players: [Player] = []
    var activePlayer: Player

    // Set up settings
    /// The maximum number of houses per property
    let maxHouseNumber = 5

    /// The starting price for properties (Brown spaces)
    let propertyStartingPrice = 60

    /// The difference of price between 2 groups
    let propertyAddingPrice = 40

    /// The difference of price between the group and the top property of group
    let propertyTopPrice = 20

    /// The difference between Green and Blue
    let topPropertyPrice = 10

    /// The difference of price between 2nd last property and last property
    let topPropertyTopPrice = 50

    /// Price to buy a Railroad
    let railroadPrice = 200

    /// Price to buy a Utility
    let utilityPrice = 150

    /// Amount of money a player starts with
    let playerStartingFunds = 1500
    
    let endRound: Double = 200.0
    let luxaryTax: Double = 100.0
    let incomeTax: Double = 200.0
    

    /// Rent price for railroad if one is owned
    let railroadRentPrice = 25

    /// Factor for multiplication for a utility if one is owned
    /// - SeeAlso: utilityTwoMultiplier
    let utilityOneMultiplier = 100

    /// Factor for multiplication for a utility if two are owned
    /// - SeeAlso: utilityOneMultiplier
    let utilityTwoMultiplier = 4

    // Cards
    /// Array for "Chance" cards
    /// - Warning: Only "Get out of Jail Free" cards should get removed (and re-added)
    /// - SeeAlso: communityChestCards
    var chanceCards: [Card] = []

    /// Array for "Community Chest" cards
    /// - Warning: Only "Get out of Jail Free" cards should get removed (and re-added)
    /// - SeeAlso: chanceCards
    var communityChestCards: [Card] = []

    /// Provides two random integers between 1 and 6
    /// - Returns: Two Integers from 1 to 6
    
    func diceRoll() -> DiceResult {
        let die1 = Int(arc4random_uniform(6) + 1)
        let die2 = Int(arc4random_uniform(6) + 1)
        
        return (die1, die2)
    }

    
    func nextTurn() {
        let result = diceRoll()
        delegate?.diceThrowResult(result, for: activePlayer)
        let space = activePlayer.currentSpace!
        let index = map.index { $0.nodeName == space.nodeName }!
        var newIndex = index + result.die1 + result.die2
        
        if newIndex >= map.count {
           newIndex = newIndex - map.count 
        }
        let newSpace = map[newIndex]
        activePlayer.currentSpace = newSpace
        activePlayer = nextPlayer()
        
    }
    
    func nextPlayer() -> Player {
        let index = players.index { $0.id == activePlayer.id }!
        var nextIndex = index + 1
        if nextIndex >= players.count {
            nextIndex -= players.count
        }
        return players[nextIndex]
    }
    
    /// Send player to jail
    ///
    /// Sending a player to jail means that the player
    /// cannot move through the board. A player in jail
    /// has to roll doubles or pay bail to get out.
    ///
    /// If player has a card, just move space
    /// - TODO: Remove card from player and re-place in card Array
    func sendToJail(player: Player) {
//        playerInJail = true
//        if playerHasFreeCard.isEmpty != true {
//            playerInJail = false
//            playerHasFreeCard.removeFirst() // Remove free card
//        }
//        currentSpace = spaceArray[10]
    }

    // Extra functions
    /// Give a choice to a player whether to pay the full
    /// de-mortgage price or 10% right away.
    func onMortgageChangeChoice() -> Bool {
        return false
    }
}
