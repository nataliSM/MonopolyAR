//
//  Coin.swift
//  MonopolyAR
//
//  Created by Никита Солдатов on 11.05.2018.
//  Copyright © 2018 ru.itis.iosLab. All rights reserved.
//

import Foundation
import SceneKit
class Coin {
    let node: SCNNode
    init() {
        let scene = SCNScene(named: "objects.scnassets/coin.scn")!
        let chestNode = scene.rootNode.childNode(withName: "coin", recursively: true)!
        chestNode.removeFromParentNode()
        
        self.node = chestNode
    }
}

