//
//  CityBuilder.swift
//  FlappyClone
//
//  Created by Jin Kang on 3/6/18.
//  Copyright © 2018 Jin Kang. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit

class CityBuilder {
    
    // city variables
    var city1Image = UIImage(named: "City1")
    var city2Image = UIImage(named: "City2")
    var city3Image = UIImage(named: "City3")
    var city1Point = CGPoint(x: 0, y: 0)
    var city2Point = CGPoint(x: 0, y: 0)
    var city3Point = CGPoint(x: 0, y: 0)
    var citySpriteArray: [SKSpriteNode] = [SKSpriteNode]()
    var startCity1Position = CGPoint()
    var startCity2Position = CGPoint()
    var city1Array = [SKSpriteNode]()
    var city2Array = [SKSpriteNode]()
    let random = Int(arc4random_uniform(3))
    var nextBuildingLocation1 = CGPoint()
    var nextBuildingLocation2 = CGPoint()
    
    let city1Sprite: SKSpriteNode = SKSpriteNode(imageNamed: "City1")
    let city2Sprite: SKSpriteNode = SKSpriteNode(imageNamed: "City2")
    let city3Sprite: SKSpriteNode = SKSpriteNode(imageNamed: "City3")
    let ground: SKSpriteNode = SKSpriteNode(imageNamed: "Ground")
    var counter = 0

    
    func buildingLocation(){
        var citySpriteArray1 = GameScene().citySpriteArray1
        var citySpriteArray2 = GameScene().citySpriteArray2
        
        var oldLocation1 = citySpriteArray1[counter]
        var oldLocation2 = citySpriteArray2[counter]
        
        
        
        
    }
    
    
    init() {
        
    }
    
    
    // This function takes in the two halves of the city and then calculates the future position of the next appending building from the previous building in the array
    
    
}
