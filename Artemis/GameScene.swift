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
    var volume: Int = 0
    var volumeLabel: UILabel!
    var underwears: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        self.addChild(background)
        
        for i in 0...4 {
            let underwear = SKSpriteNode(imageNamed: "underwear.png")
            underwear.position = CGPoint(x: (CGFloat(i+1)) * size.width / 5 - underwear.size.width / 2, y: 5 * size.height / 6)
            underwear.zPosition = 1
            addChild(underwear)
            underwears.append(underwear)
        }
        
        volumeLabel = UILabel()
//        volumeLabel.center = CGPoint(x: frame.size.width / 2, y: 3 * frame.size.height / 4)
        volumeLabel.center = CGPoint(x: 0, y: 0)

        volumeLabel.textAlignment = NSTextAlignment.left
        volumeLabel.text = String(volume) + " mL"

        volumeLabel.textColor = SKColor.white
        self.view?.addSubview(volumeLabel)
        
        cup.position = CGPoint(x: size.width / 2, y: size.height / 4)
        cup.zPosition = 1
        addChild(cup)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        run(SKAction.playSoundFileNamed("drop_sound.mp3",
                                              waitForCompletion: false))
        
        for touch in touches {
            if touch.location(in: background).x <= 0 {
                if cup.position.x - 50 >= cup.size.width/2 {
                    let newPos = CGPoint(x: cup.position.x - 50, y: cup.position.y)
                    let actionMove = SKAction.move(to: newPos, duration: 0.1)
                    cup.run(actionMove)
                } else {
                    let newPos = CGPoint(x: cup.size.width/2, y: cup.position.y)
                    let actionMove = SKAction.move(to: newPos, duration: 0.1)
                    cup.run(actionMove)
                }
            } else {
                if cup.position.x + 50 <= size.width - cup.size.width/2 {
                    let newPos = CGPoint(x: cup.position.x + 50, y: cup.position.y)
                    let actionMove = SKAction.move(to: newPos, duration: 0.1)
                    cup.run(actionMove)
                } else {
                    let newPos = CGPoint(x: size.width - cup.size.width/2, y: cup.position.y)
                    let actionMove = SKAction.move(to: newPos, duration: 0.1)
                    cup.run(actionMove)
                }
            }

            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        addDrop()
        if drops.count > 1 {
            for i in stride(from: drops.count-1, to: -1, by: -1) {
                if getBottomY(sprite: drops[i]) < getTopY(sprite: cup) && (getLeftX(sprite: drops[i]) > getLeftX(sprite: cup) && getRightX(sprite: drops[i]) < getRightX(sprite: cup)) {
                    drops[i].removeFromParent()
                    drops.remove(at: i)
                    volume += 1
                }
            }
        }
    }
    
    func getLeftX(sprite: SKSpriteNode) -> Float {
        return Float(sprite.position.x - sprite.size.width/2)
    }
    
    func getRightX(sprite: SKSpriteNode) -> Float {
        return Float(sprite.position.x + sprite.size.width/2)
    }
    
    func getTopY(sprite: SKSpriteNode) -> Float {
        return Float(sprite.position.y + sprite.size.width/2)
    }
    
    func getBottomY(sprite: SKSpriteNode) -> Float {
        return Float(sprite.position.y - sprite.size.width/2)
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
        
        // Add the drop to the scene
        addChild(drop)
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(4.0), max: CGFloat(8.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: -drop.size.height/2), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        drop.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
}
