//
//  Lepricon.swift
//  MonopolyAR
//
//  Created by Наталья on 09.12.2017.
//  Copyright © 2017 ru.itis.iosLab. All rights reserved.
//

import SceneKit

final class Lepricon: SCNNode, PlayerObject {
    var node: SCNNode
    var moneyLabel: SCNNode
    override init() {
        let scene = SCNScene(named: "lepricon.scn")!
        let node = scene.rootNode.childNode(withName: "lepricon", recursively: true)!
        self.moneyLabel = node.childNode(withName: "money", recursively: false)!
        self.node = node
        super.init()
        addChildNode(node)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }


//    func runAppearAnimation() {
//        lepriconNode?.position.y = -1
//        removeAllActions()
//        removeAllParticleSystems()
//        scale = SCNVector3(0.1, 0.1, 0.1)
//        addParticleSystem(SCNParticleSystem(named: "mushroom-appear", inDirectory: nil)!)
//        let scaleAction = SCNAction.scale(to: 1.0, duration: 1.0)
//        let removeParticle = SCNAction.run { _ in
//            self.removeAllParticleSystems()
//        }
//        let sequence = SCNAction.sequence([scaleAction, removeParticle])
//        runAction(sequence)
//    }
  



}
