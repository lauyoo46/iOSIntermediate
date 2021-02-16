//
//  Scene.swift
//  ARDemo
//
//  Created by Laurentiu Ile on 03/02/2021.
//

import SpriteKit
import ARKit

class Scene: SKScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        
        if let touchLocation = touches.first?.location(in: self) {
            if let node = nodes(at: touchLocation).first as? SKLabelNode {
                
                let fadeOut = SKAction.fadeOut(withDuration: 1.0)
                node.run(fadeOut) {
                    node.removeFromParent()
                }
                
                return
            }
        }
        
        if let currentFrame = sceneView.session.currentFrame {

            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.5
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
        }
    }
}
