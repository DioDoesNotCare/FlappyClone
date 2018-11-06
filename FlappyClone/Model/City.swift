//
//  City.swift
//  FlappyClone
//
//  Created by Jin Kang on 2/28/18.
//  Copyright © 2018 Jin Kang. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class City {
    var cityWidth: CGFloat
    var cityHeight: CGFloat
    var sprite: SKNode
    
    init(sprite: SKNode, cityWidth: CGFloat, cityHeight: CGFloat){
        self.cityHeight = cityHeight
        self.cityWidth = cityWidth
        self.sprite = sprite
    }
    
}
