//
//  ViewController.swift
//  ARNewspaper
//
//  Created by Laurentiu Ile on 04/02/2021.
//

import UIKit
import SceneKit
import ARKit

class NewspaperViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    let videoPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "snowboarding", withExtension: "mp4") else {
            return AVPlayer()
        }
        return AVPlayer(url: url)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        let scene = SCNScene()
        sceneView.scene = scene
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                               object: self.videoPlayer.currentItem,
                                               queue: .main) { [weak self] (notification) in
            self?.videoPlayer.seek(to: CMTime.zero)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARImageTrackingConfiguration()
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources",
                                                                     bundle: Bundle.main) else {
            fatalError("Failed to load the reference images")
        }
        
        configuration.trackingImages = referenceImages
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return
        }
        
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                             height: imageAnchor.referenceImage.physicalSize.height)
        
        plane.firstMaterial?.diffuse.contents = self.videoPlayer
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.eulerAngles.x = -.pi / 2
        
        node.addChildNode(planeNode)
        
        self.videoPlayer.play()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        if let pointOfView = sceneView.pointOfView {
            let isVisible = sceneView.isNode(node, insideFrustumOf: pointOfView)
                
            if isVisible == true {
                if videoPlayer.rate == 0.0 {
                    videoPlayer.play()
                }
            }
        }
    }
}
