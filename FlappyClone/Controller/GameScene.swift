//
//  GameScene.swift
//  FlappyClone
//
//  Created by Jin Kang on 2/15/18.
//  Copyright © 2018 Jin Kang. All rights reserved.
//
//

import SpriteKit
import GameplayKit
import UIKit

// SKScene = SpriteKitScene super class for 2-D images
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // GKEntity: GameplayKit Entity is an object that represents an entity in games with Entity-Component Architecture. An entity defines no functionality on it's own, defined by components that handle different aspects of the entity's behavior. 
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var gameTimer: Timer!
    var Ground = SKSpriteNode()
    var player: SKSpriteNode = SKSpriteNode()
    var color: UIColor = UIColor.red
    var Box: SKSpriteNode = SKSpriteNode()
    // location variables
    var leverTouchPointLocation: CGPoint = CGPoint()
    var fingerLocation: CGPoint = CGPoint()
    
    // boolean variables
    var isRed: Bool = true
    var boxTouched: Bool = false
    var letGo: Bool = false
    
    // force calculation variables
    var theta: CGFloat = CGFloat(Double.pi)/2
    var xForce: CGFloat = 0.0
    var yForce: CGFloat = 0.0
    var forceVector: CGVector = CGVector(dx: 0, dy: 5.0)
    
    
    // City variables
    var citySpriteArray: [SKSpriteNode] = [SKSpriteNode]()
    let random = Int(arc4random_uniform(3))
    let city1Sprite: SKSpriteNode = SKSpriteNode(imageNamed: "City1")
    let city2Sprite: SKSpriteNode = SKSpriteNode(imageNamed: "City2")
    let city3Sprite: SKSpriteNode = SKSpriteNode(imageNamed: "City3")
    var startCity1 = SKSpriteNode()
    var startCity2 = SKSpriteNode()
    var citySpriteArray1: [SKSpriteNode] = [SKSpriteNode]()
    var citySpriteArray2: [SKSpriteNode] = [SKSpriteNode]()
    var citySpriteStringArray: [String] = ["City1", "City2", "City3"]
    
    override func sceneDidLoad() {
        
        // Player/World/Lever initiate
        self.physicsWorld.contactDelegate = self
        player = SKSpriteNode(imageNamed: "Ghost")
        player.physicsBody?.isDynamic = true
        player.position.x = self.size.width/2
        player.position.y = Ground.size.height + player.size.height/2
        self.addChild(player)
        
        //Box initialize position and as a node
        Box = childNode(withName: "RedSquare") as! SKSpriteNode
        Box.position.x = self.size.width / 2
        Box.position.y = 320
        Ground = childNode(withName: "Ground") as! SKSpriteNode
        Ground.position.x = 375
        Ground.position.y = 29.4
        citySpriteArray.append(city1Sprite)
        citySpriteArray.append(city2Sprite)
        citySpriteArray.append(city3Sprite)
        
        initialBuildings()
        self.addChild(startCity1)
        self.addChild(startCity2)
        
    }
    
    func initialBuildings() -> (SKSpriteNode, SKSpriteNode) {
        
        startCity1 = citySpriteArray[self.random]
        citySpriteArray1.append(startCity1)
        startCity1.position.x = self.size.width/2 - startCity1.size.width/2 - self.player.size.width
        startCity1.position.y = self.Ground.size.height + startCity1.size.height/2
        
        while true {
            let random = Int(arc4random_uniform(3))
            if random != self.random {
                startCity2 = citySpriteArray[random]
                citySpriteArray2.append(startCity2)
                startCity2.position.x = self.size.width/2 + startCity2.size.width/2 + self.player.size.width
                startCity2.position.y = self.Ground.size.height + startCity2.size.height/2
                break
            }
        }
        
        return (startCity1, startCity2)
    }
    
    func didMoveToView(to: SKView){
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    // What happens after Lever is touched (colors for now)
    func buttonTouch() {
        if self.isRed == true {
            self.color = SKColor.blue
            Box.color = color
            isRed = false
            
        } else {
            self.color = SKColor.red
            Box.color = color
            isRed = true
        }
    }
    
    func addBuildings() {
        // picks two random buildings from the randomCity() function which are placed in the city arrays, then rotates the last building of each array using the rotateAppendingBuildings1 and 2 randomly, then find the location of placement for each of the last buildings of the arry from the appendingCityLocation function
        
        let randomShit1 = Int(arc4random_uniform(UInt32(citySpriteArray.count)))
        let randomShit2 = Int(arc4random_uniform(UInt32(citySpriteArray.count)))
        
        let randomBuilding1 = SKSpriteNode(imageNamed: citySpriteStringArray[randomShit1])
        let randomBuilding2 = SKSpriteNode(imageNamed: citySpriteStringArray[randomShit2])
        
        citySpriteArray1.append(randomBuilding1)
        citySpriteArray2.append(randomBuilding2)
        
        let building1 = citySpriteArray1[citySpriteArray1.count - 1]
        let building2 = citySpriteArray2[citySpriteArray2.count - 1]
        
        
        
        self.addChild(building1)
        self.addChild(building2)
        
        // add the physics property of each of the buildings to make sure tyhat if the buildings make contact with the helicopter the game will end.
        
    }
    
    // Touches began must be on the level (or around it?)
    // for now the buildings will be generated if you press on the box
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        for t in touches {
            let location = t.location(in: self)
            if (location.x < self.size.width/2 + 50) && (location.x > self.size.width/2 - 50) && location.y > 220 && location.y < 420 {
                boxTouched = true
                self.leverTouchPointLocation = location
                self.buttonTouch()
                addBuildings()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    // If finger is moved, find finger location which
    func touchMoved(toPoint pos : CGPoint) {
        letGo = false
        fingerLocation = pos
    }
    
    // If you let go of the button, no change in force but previous force will continue
    func touchUp(atPoint pos : CGPoint) {
        letGo = true
    }
    
    func rotation() {
        if boxTouched == true {
            if fingerLocation.y > leverTouchPointLocation.y {
                player.run(SKAction.rotate(byAngle: CGFloat(-Double.pi/60), duration: 0.2))
                theta = theta - CGFloat(Double.pi/60)
                forceChange()
            }
            if fingerLocation.y < leverTouchPointLocation.y {
                player.run(SKAction.rotate(byAngle: CGFloat(Double.pi/60), duration: 0.2))
                theta = theta + CGFloat(Double.pi/60)
                forceChange()
            }
            else {
            }
        }
        else {
            player.run(SKAction.repeatForever(SKAction.moveBy(x: xForce, y: yForce, duration: 0.7)))
        }
    }
    
    // Calculates force vectors of x and y direction for movement
    func forceChange() {
        xForce = cos(theta) * 7.5
        yForce = sin(theta) * 8.2
        forceVector.dx = xForce
        forceVector.dy = yForce - 3.2
    }
    
    // Moves the player according to force vector, function gets called from time update
    func move(xForce: CGFloat, yForce: CGFloat) {
        player.run(SKAction.move(by: forceVector, duration: 0.7))
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if letGo == true {
            move(xForce:self.xForce, yForce:self.yForce)
        }
        else {
            rotation()
            move(xForce:self.xForce, yForce:self.yForce)
        }
        
            
        

        
    }
}
