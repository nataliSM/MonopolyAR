//
//  GameController.swift
//  MonopolyAR
//
//  Created by Наталья on 09.12.2017.
//  Copyright © 2017 ru.itis.iosLab. All rights reserved.
//

import SceneKit

protocol GameControllerDelegate: class {
    func askBuyPermission(_ ownedSpace: OwnedSpaceProtocol, completion: @escaping (Bool) -> Void)
}

final class GameController: MonopolyDelegate {
    private let sceneSize = 25
    weak var delegate: GameControllerDelegate?
    public var mapNode: SCNNode!
    var monopoly: Monopoly
    let text: SCNNode!
    init() {
        let monopolyScene = SCNScene(named: "monopoly.scn")!
        mapNode = monopolyScene.rootNode.childNode(withName: "monopoly_map", recursively: true)!
        let scale = SCNVector3Make(0.05, 0.05, 0.05)
        let lepriconNode = Lepricon()
        lepriconNode.scale = scale
        mapNode.addChildNode(lepriconNode)
        let lepriconPlayer = Player(id: 0, name: "Lepricon", object: lepriconNode)
        let smurfNode = Smurf()
//        dice = Dice()
//        dice.pivot = SCNMatrix4MakeTranslation(5, 0, 0)
        smurfNode.scale = scale
        mapNode.addChildNode(smurfNode)
        let smurfPlayer = Player(id: 1, name: "Smurf", object: smurfNode)
        self.text = mapNode.childNode(withName: "text", recursively: true)!
        let box = text.boundingBox
        text.pivot = SCNMatrix4MakeTranslation((box.max.x + box.min.x) / 2, 0, 0);
        
        self.monopoly = Monopoly(players: [lepriconPlayer, smurfPlayer], mapNode: mapNode)
        monopoly.delegate = self
        startRotation()
    }
    
    func updatePlayersObjects(with angle: vector_float3) {
        monopoly.players.forEach({ (player) in
            player.object.eulerAngles = SCNVector3(x: player.object.eulerAngles.x, y: player.object.eulerAngles.y, z: angle.y)
        })
    }
    
    func startRotation() {
        let rotateAction = SCNAction.rotate(by: CGFloat.pi * 2, around: SCNVector3(0, 0, 1), duration: 10.0)
        text.runAction(SCNAction.repeatForever(rotateAction))
    }

    func addToNode(rootNode: SCNNode) {
        
        rootNode.addChildNode(mapNode)
//        monopolyScene.scale = SCNVector3(0.1, 0.1, 0.1)
    }
    
    func diceThrowResult(_ result: DiceResult, for player: Player) {
        (text.geometry as! SCNText).string = "\(result.die1 + result.die2)"
        let box = text.boundingBox
        text.pivot = SCNMatrix4MakeTranslation((box.max.x + box.min.x) / 2, 0, 0);
    }
    
    func playerBalanceDidChange(_ player: Player, balance: Double) {
        
    }
    
    func playerDidBuyProperty(_ player: Player, property: PropertySpace) {
        
    }
    
    func playerDidStepOnOwnedSpace(_ player: Player, ownedSpace: OwnedSpaceProtocol) {
        delegate?.askBuyPermission(ownedSpace, completion: { (isBuy) in
            if isBuy {
                ownedSpace.updateOwner(player)
            }
        })
    }

    
}
