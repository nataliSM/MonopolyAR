//
//  GameController.swift
//  MonopolyAR
//
//  Created by Наталья on 09.12.2017.
//  Copyright © 2017 ru.itis.iosLab. All rights reserved.
//

import SceneKit

final class GameController {
    private let sceneSize = 25
    let map = Map()

    public var monopolySceneNode: SCNNode?

    var catNode: Cat
    var catPosition: int2 = int2(10, 0)
    var lepriconNode: Lepricon
    var lepriconPosition: int2 = int2(10, 0)
    var currentLepriconPosition: Int = 0
    var currentSmurfPosition: Int = 0

    init() {
        if let monopolyScene = SCNScene(named: "monopolyScene.scn") {
            monopolySceneNode = monopolyScene.rootNode.childNode(withName: "monopolyScene", recursively: true)
            monopolySceneNode?.removeFromParentNode()
        }
        lepriconNode = Lepricon()
        lepriconNode.scale = SCNVector3Make(0.1, 0.1, 0.1)
        catNode = Cat()
        catNode.scale = SCNVector3Make(0.1, 0.1, 0.1)
    }

    func reset() {
        monopolySceneNode?.addChildNode(lepriconNode)
        let lepriconPosition = map.position(for: currentLepriconPosition, step: 0)
        placeLepricon(position: lepriconPosition)
        monopolySceneNode?.addChildNode(catNode)
         let smurfPosition = map.position(for: currentSmurfPosition, step: 0)
        placeCat(position: smurfPosition)
        
    }

    func addToNode(rootNode: SCNNode) {
        guard let monopolyScene = monopolySceneNode else {
            return
        }
        monopolyScene.removeFromParentNode()
        rootNode.addChildNode(monopolyScene)
        monopolyScene.scale = SCNVector3(0.1, 0.1, 0.1)
    }
    
    func step(on steps: Int) {
        lepriconNode.removeFromParentNode()
        monopolySceneNode?.addChildNode(lepriconNode)
        let position = map.position(for: currentLepriconPosition, step: steps)
        currentLepriconPosition += steps
        placeLepricon(position: position)
        
    }
    
    func placeLepricon(position: Position) {
        lepriconPosition = position.coordinare
    
        lepriconNode.position = SCNVector3(Float(lepriconPosition.x), Float(lepriconPosition.y), Float(0))
        lepriconNode.runAppearAnimation()
    }

    func stepCat(on steps: Int) {
        catNode.removeFromParentNode()
        monopolySceneNode?.addChildNode(catNode)
        let position = map.position(for: currentSmurfPosition, step: steps)
        currentSmurfPosition += steps
        placeCat(position: position)

    }

    func placeCat(position: Position) {
        catPosition = position.coordinare

        catNode.position = SCNVector3(Float(catPosition.x), Float(catPosition.y), Float(0))
        catNode.runAppearAnimation()
    }
    
}
