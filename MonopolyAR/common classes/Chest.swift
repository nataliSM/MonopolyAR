//
//  Chest.swift
//  MonopolyAR
//
//  Created by Никита Солдатов on 07.05.2018.
//  Copyright © 2018 ru.itis.iosLab. All rights reserved.
//

import Foundation
import SceneKit
class Chest {
    let node: SCNNode
    init() {
        
        let scene = SCNScene(named: "objects.scnassets/box.scn")!
        let chestNode = scene.rootNode.childNode(withName: "box", recursively: true)!
        chestNode.removeFromParentNode()
        
        self.node = chestNode
    }
    
}
