//
//  Cat.swift
//  MonopolyAR
//
//  Created by Наталья on 12.12.2017.
//  Copyright © 2017 ru.itis.iosLab. All rights reserved.
//

import SceneKit

protocol PlayerObject {
    var node: SCNNode { get }
    var moneyLabel: SCNNode { get }
    func updateMoney(with founds: Double)
}

extension PlayerObject {
    func updateMoney(with funds: Double) {
        let money = node.childNode(withName: "money", recursively: false)!
//        var box = money.boundingBox
//        print("Box \(box.min) - \(box.max)")
        (money.geometry as! SCNText).string = "\(funds)£"
//        box = money.boundingBox
//        print("Box \(box.min) - \(box.max)")
//        money.pivot = SCNMatrix4MakeTranslation((box.max.x + box.min.x) / 2, 0, 0);
    }
}

final class Smurf: SCNNode, PlayerObject {
    var node: SCNNode
    var moneyLabel: SCNNode
    override init() {
        let scene = SCNScene(named: "Papa_Smurf.scn")!
        let node = scene.rootNode.childNode(withName: "papaSmurf", recursively: true)!
        self.moneyLabel = node.childNode(withName: "money", recursively: false)!
        self.node = node
        super.init()
        addChildNode(node)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
//
//    func runAppearAnimation() {
//        catNode?.position.y = -1
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
