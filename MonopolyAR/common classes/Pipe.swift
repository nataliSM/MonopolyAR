//
//  Pipe.swift
//  MonopolyAR
//
//  Created by Никита Солдатов on 11.05.2018.
//  Copyright © 2018 ru.itis.iosLab. All rights reserved.
//

import Foundation
import SceneKit
class Pipe {
    let node: SCNNode
    init() {
        let scene = SCNScene(named: "objects.scnassets/pipe.scn")!
        let chestNode = scene.rootNode.childNode(withName: "pipe", recursively: true)!
        chestNode.removeFromParentNode()
        
        self.node = chestNode
    }
}

