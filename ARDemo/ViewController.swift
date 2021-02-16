//
//  ViewController.swift
//  ARDemo
//
//  Created by Laurentiu Ile on 03/02/2021.
//

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    
    let birdFrames = [SKTexture(imageNamed: "frame-1"), SKTexture(imageNamed: "frame-2"),
                      SKTexture(imageNamed: "frame-3"), SKTexture(imageNamed: "frame-4"),
                      SKTexture(imageNamed: "frame-5"), SKTexture(imageNamed: "frame-6"),
                      SKTexture(imageNamed: "frame-7"), SKTexture(imageNamed: "frame-8") ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
 
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true

        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {

        let spriteNode = SKSpriteNode(texture: birdFrames[0])
        spriteNode.position = CGPoint(x: view.center.x, y: view.center.y)
        let flyingAction = SKAction.repeatForever(SKAction.animate(with: birdFrames, timePerFrame: 0.01))
        spriteNode.run(flyingAction)
        spriteNode.size = CGSize(width: spriteNode.size.width * 0.05, height: spriteNode.size.height * 0.05)
        return spriteNode
    }
}
