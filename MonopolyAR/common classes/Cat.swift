//
//  Cat.swift
//  MonopolyAR
//
//  Created by Наталья on 12.12.2017.
//  Copyright © 2017 ru.itis.iosLab. All rights reserved.
//

import SceneKit

final class Cat: SCNNode {
    var catNode: SCNNode?

    override init() {
        super.init()
        if let scene = SCNScene(named: "Papa_Smurf.scn"), let catNode = scene.rootNode.childNode(withName: "papaSmurf", recursively: true) {
            addChildNode(catNode)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }


    func runAppearAnimation() {
        catNode?.position.y = -1
        removeAllActions()
        removeAllParticleSystems()
        scale = SCNVector3(0.1, 0.1, 0.1)
        addParticleSystem(SCNParticleSystem(named: "mushroom-appear", inDirectory: nil)!)
        let scaleAction = SCNAction.scale(to: 1.0, duration: 1.0)
        let removeParticle = SCNAction.run { _ in
            self.removeAllParticleSystems()
        }
        let sequence = SCNAction.sequence([scaleAction, removeParticle])
        runAction(sequence)
    }




}
