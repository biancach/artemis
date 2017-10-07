//
//  GameScene.swift
//  Artemis
//
//  Created by Bianca on 07/10/2017.
//  Copyright © 2017 Bianca. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let cup = SKSpriteNode(imageNamed: "cup.png")
    let background = SKSpriteNode(imageNamed: "art_background.png")

    var dropCount: Int = 0
    var drops:  Array<SKSpriteNode> = Array()
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        self.addChild(background)
        
        cup.position = CGPoint(x: size.width/2, y: size.height/4)
        cup.zPosition = 1
        addChild(cup)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        run(SKAction.playSoundFileNamed("drop_sound.mp3",
                                              waitForCompletion: false))
        
        for touch in touches {
            if touch.location(in: background).x <= 0 {
                let newPos = CGPoint(x: cup.position.x - 50, y: cup.position.y)
                let actionMove = SKAction.move(to: newPos, duration: 0.1)
                cup.run(actionMove)
            } else {
                let newPos = CGPoint(x: cup.position.x + 50, y: cup.position.y)
                let actionMove = SKAction.move(to: newPos, duration: 0.1)
                cup.run(actionMove)
            }

            
        }
    }
    

    func touchDown(atPoint pos : CGPoint) {
        addDrop()
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        addDrop()
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func randNumber() -> Float {
        return Float(drand48())
    }
    
    func addDrop() {
        
        // Create sprite
        let drop = SKSpriteNode(imageNamed: "small_drop.png")
        drops.append(drop)
        
        // Determine where to spawn the drop along the X axis
        let actualX = random(min: drop.size.width/2, max: size.width - drop.size.width/2)
        
        // Position the drop slightly off-screen along the right edge,
        // and along a random position along the X axis as calculated above
        drop.position = CGPoint(x: actualX, y: size.height + drop.size.height/2)
        
        // Add the monster to the scene
        addChild(drop)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: -drop.size.height/2), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        drop.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
}