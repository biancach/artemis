//
//  BackgroundNode.swift
//  Artemis
//
//  Created by Bianca on 07/10/2017.
//  Copyright © 2017 Bianca. All rights reserved.
//

import Foundation
import SpriteKit

public class BackgroundNode : SKNode {
    
    public func setup(size : CGSize) {
        let yPos : CGFloat = size.height * 0.10
        let startPoint = CGPoint(x: 0, y: yPos)
        let endPoint = CGPoint(x: size.width, y: yPos)
        physicsBody = SKPhysicsBody(edgeFrom: startPoint, to: endPoint)
        physicsBody?.restitution = 0.3
    }
}
