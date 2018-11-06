//
//  GameViewController.swift
//  FlappyClone
//
//  Created by Jin Kang on 2/15/18.
//  Copyright © 2018 Jin Kang. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    // MARK: Properties
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene (Sprite Kit Scene / Game Kit Scene)
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }

    // MARK: Functions
    
    // This function makes all the game view contents rotate when you flip the phone
    override var shouldAutorotate: Bool {
        return true
    }
    
    // returns style of interface to use on current device, finds it through name, of device, system name, system version, model, etc...
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    // This function is called when the view controller has a memory problem
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // This function makes teh status bar hidden
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
