//
//  Train.swift
//  MonopolyAR
//
//  Created by Никита Солдатов on 11.05.2018.
//  Copyright © 2018 ru.itis.iosLab. All rights reserved.
//

import Foundation
import SceneKit
class Train {
    let node: SCNNode
    init() {
        let scene = SCNScene(named: "objects.scnassets/train.scn")!
        let chestNode = scene.rootNode.childNode(withName: "train", recursively: true)!
        chestNode.removeFromParentNode()
        
        self.node = chestNode
    }
}
