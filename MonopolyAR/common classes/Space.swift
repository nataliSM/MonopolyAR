//
//  Space.swift
//  MonopolyAR
//
//  Created by Никита Солдатов on 07.05.2018.
//  Copyright © 2018 ru.itis.iosLab. All rights reserved.
//

import Foundation
import SceneKit

protocol SpaceProtocol {
    var nodeName: NodeName { get }
    var node: SCNNode { get }
    func whenPlayerOnSpace(_ player: Player)
}

struct Policy {
    var price: Double
    var tax: Double
    
}

class ActionSpace: SpaceProtocol {
    
    enum Action {
        case tax(price: Double)
        case communityChest
        case chance
        case toJail
        case start(price: Double)
        case none
    }
    var nodeName: NodeName
    var node: SCNNode
    var action: Action
    init(nodeName: NodeName, node: SCNNode, action: Action) {
        self.action = action
        self.nodeName = nodeName 
        self.node = node
    }
    
    func whenPlayerOnSpace(_ player: Player) {
        switch action {
        case .tax(let price): player.removeMoney(amount: price)
        case .start(let price):  player.removeMoney(amount: price)
        default: return
        }
    }
}

protocol OwnedSpaceProtocol: SpaceProtocol {
    var owner: Player? { get set }
    var ownershipPolicy: Policy { get }
    func updateOwner(_ newOwner: Player)
    var stepOnEmty: ((OwnedSpaceProtocol, Player) -> Void)? { get set }
}

extension OwnedSpaceProtocol {
    func whenPlayerOnSpace(_ player: Player) {
        guard let owner = owner else {
            stepOnEmty?(self, player)
            return
        }
        if player != owner {
            player.removeMoney(amount: ownershipPolicy.tax)
            owner.addMoney(amount: ownershipPolicy.tax)
        }
    }
}

class ComunalSpace: OwnedSpaceProtocol {
    
    var nodeName: NodeName
    var ownershipPolicy: Policy
    var owner: Player?
    var node: SCNNode
    var stepOnEmty: ((OwnedSpaceProtocol, Player) -> Void)?
    
    init(ownershipPolicy: Policy, node: SCNNode, nodeName: NodeName) {
        self.ownershipPolicy = ownershipPolicy
        self.node = node
        self.nodeName = nodeName
    }
    
    func updateOwner(_ newOwner: Player) {
        newOwner.removeMoney(amount: ownershipPolicy.price)
        node.isHidden = false
        let playerPlace = node.childNode(withName: "place_players", recursively: false)!
        playerPlace.isHidden = false
        let material = playerPlace.geometry!.material(named: "color")!
        material.diffuse.contents = UIColor.green
        
        self.owner = newOwner
    }
    
}

class TrainStationSpace: OwnedSpaceProtocol {
    var nodeName: NodeName
    var ownershipPolicy: Policy
    var owner: Player?
    var node: SCNNode
    var stepOnEmty: ((OwnedSpaceProtocol, Player) -> Void)?
    
    init(ownershipPolicy: Policy, node: SCNNode, nodeName: NodeName) {
        self.ownershipPolicy = ownershipPolicy
        self.node = node
        self.nodeName = nodeName
    }
    
    func updateOwner(_ newOwner: Player) {
        newOwner.removeMoney(amount: ownershipPolicy.price)
        node.isHidden = false
        let playerPlace = node.childNode(withName: "place_players", recursively: false)!
        playerPlace.isHidden = false
        let material = playerPlace.geometry!.material(named: "color")!
        material.diffuse.contents = UIColor.green
        
        self.owner = newOwner
    }
    
}

class PropertySpace: OwnedSpaceProtocol {
    var nodeName: NodeName
    var ownershipPolicy: Policy
    var owner: Player?
    var node: SCNNode
    var stepOnEmty: ((OwnedSpaceProtocol, Player) -> Void)?

    init(ownershipPolicy: Policy, node: SCNNode, nodeName: NodeName) {
        self.ownershipPolicy = ownershipPolicy
        self.node = node
        self.nodeName = nodeName
    }
    
    func updateOwner(_ newOwner: Player) {
        newOwner.removeMoney(amount: ownershipPolicy.price)
        node.isHidden = false
        let playerPlace = node.childNode(withName: "place_players", recursively: false)!
        playerPlace.isHidden = false
        let material = playerPlace.geometry!.material(named: "color")!
        material.diffuse.contents = UIColor.green
        
        self.owner = newOwner
    }
    
}
