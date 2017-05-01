//
//  GameScene.swift
//  Cat Bonkers
//
//  Created by Christine Buell on 1/21/17.
//  Copyright © 2017 Christine Buell. All rights reserved.
//

import SpriteKit
import UIKit
import Foundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    let BorderCategory    : UInt32 = 0x1 << 1
    let LadybugCategory : UInt32 = 0x1 << 2
    var background = SKSpriteNode(imageNamed: "smallerPavementArtboard.png")
    let firstMove = FirstMove()
    let gameLooping = GameLoop()
    
    //Bird action variables
    var newExitPos = CGPoint()
    var newExitSide = Int()
    var newStartPos = CGPoint()
    var tappedBug = SKNode()
    var touched:Bool = false
    var nodeTouched:Bool = false
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "ladybug.atlas")
    var walkAnimation = SKAction()
    var bugTouched:Bool = false
   
    
    
    override func didMove(to view: SKView) {
        //Call Game piece, call first move, call game loop, skAction forever
        if UIScreen.main.bounds.width > 1024 {
            background = SKSpriteNode(imageNamed: "midPavement.png")
        
        }

        background.position = CGPoint(x: UIScreen.main.bounds.width / 2, y:UIScreen.main.bounds.height / 2 )
        background.zPosition = 0
        addChild(background)
        backgroundColor = SKColor .white
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        borderBody.mass = 0
        borderBody.density = 0
        borderBody.contactTestBitMask = BorderCategory
        self.physicsBody = borderBody
        self.physicsWorld.contactDelegate = self
        
        //Start Game
        beginGame()
        //Game Loop
        ladybugGameLoop()
        
    }
    func beginGame() {
        
        weak var  wSelf = self //Use weakSelf to break a possible strong reference cycle
        let beginTheGame = firstMove.firstCoordinates()
        newStartPos = beginTheGame.position
        newExitSide = beginTheGame.exitSide
        newExitPos = beginTheGame.moveTo
        
        
        //Get first exit side (beginning position)
        let spawn = SKAction.run({
            wSelf!.spawnLadybug()
        })
        //was duration 4
        let wait = SKAction.wait(forDuration: 0.3, withRange: 0.2)
        let spawning = SKAction.sequence([wait,spawn])
        run(spawning)
        
    }
    
    func createAnimation() {
        //Create bug walking animation
        
        let walkFrames:[SKTexture] = [
            
            textureAtlas.textureNamed("BlueLadybug2.png"),
            textureAtlas.textureNamed("BlueLadybug3.png"),
            textureAtlas.textureNamed("BlueLadybug2.png"),
            textureAtlas.textureNamed("BlueLadybug4.png"),
            textureAtlas.textureNamed("BlueLadybug5.png"),
            textureAtlas.textureNamed("BlueLadybug4.png")
            
        ]
        let walkAction = SKAction.animate(with: walkFrames, timePerFrame: 0.02)
        //Group together the walking animation frames
        walkAnimation = SKAction.repeatForever(walkAction)
        
    }
    
    func spawnLadybug(){
        
        let ladybug = SKSpriteNode(imageNamed: "BlueLadybug1.png")
        createAnimation()
        ladybug.name = "ladybug"
        ladybug.run(walkAnimation, withKey: "walkAnimation")
        ladybug.zPosition = 10
        //Changed from 0.6 12/6
        ladybug.setScale(0.8)
        ladybug.position = newStartPos
        ladybug.physicsBody = SKPhysicsBody(rectangleOf: ladybug.size)
        //ladybug.physicsBody = SKPhysicsBody(edgeLoopFrom: ladybug.centerRect)
    
        
        //Added mass to see if it would allow it to pass through edge physicsbody
        ladybug.physicsBody?.mass = 0
        ladybug.physicsBody?.affectedByGravity = false
        ladybug.physicsBody?.isDynamic = true
        ladybug.physicsBody?.collisionBitMask = 0 // no collisions
        ladybug.physicsBody?.contactTestBitMask = LadybugCategory
        
        
        
        //get the distance between the destination position and the node's position
        let distance: CGFloat = sqrt(pow((newExitPos.x - newStartPos.x), 2.0) + pow((newExitPos.y - newStartPos.y), 2.0))
        
        //Turn in the direction it's going
        let angle = atan2(newExitPos.y - newStartPos.y, newExitPos.x - newStartPos.x) - CGFloat(M_PI_2)
        ladybug.zRotation = angle
        
        //calculate new duration based on the distance
        //Originally was speed of 0.003
        let moveDuration: Double = 0.0025 * Double(distance)
        
        let move = SKAction.move(to: newExitPos,duration: moveDuration)
        
        let remove = SKAction.removeFromParent()
        ladybug.run(SKAction.sequence([move, remove]))
        
        SKAction.repeatForever(walkAnimation)
        self.addChild(ladybug)
        
    }
    
    func ladybugGameLoop() {
        if nodeTouched == true{
            
        }
        weak var wSelf = self
        //changed from 5
        let longWait = SKAction .wait(forDuration: 4.0)
        
        let birdFlight = SKAction.run({
            //Gets next loop coordinates from gameLoop() through gameLooping object
            let nextMove = wSelf!.gameLooping.continueLooping(wSelf!.newExitPos, exitSide: wSelf!.newExitSide)
            wSelf!.newExitSide = nextMove.newExitSide
            wSelf!.newExitPos = nextMove.newMoveTo
            wSelf!.newStartPos = nextMove.newPosition
            
            wSelf!.spawnLadybug()
        })
        
        let birdScurry = SKAction.sequence([longWait, birdFlight])
        self.run(SKAction.repeatForever(birdScurry), withKey: "birdRepeat")
    }
    
    //MARK: Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nodeTouched = true
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        //bodyAtPoint to find the physicsbody associated with that location (If there is one)
        if let body = physicsWorld.body(at: touchLocation){
            
            let nodeLocation = body.node!.convert(position, to: self)
            
            if body.node!.name != "ladybug" {
            }else{
                bugTouched = true
                tappedBug = body.node!
                removeAction(forKey: "birdRepeat")
                body.node!.removeAllActions()
                ladybugCaught(body.node!, nodeLocation: nodeLocation)
                
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        tappedBug.position = (touch?.location(in: self))!
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bugTouched != true {} else {
            let newStart = TapInterruption()
            let reStartLoop = newStart.newExitPoint()
            newExitSide = reStartLoop.exitSide
            newExitPos = reStartLoop.moveTo
            let currentPos = tappedBug.position
            
            //get the distance between the destination position and the node's position
            let distance: CGFloat = sqrt(pow((newExitPos.x - tappedBug.position.x), 2.0) + pow((newExitPos.y - tappedBug.position.y), 2.0))
            
            //calculate your new duration based on the distance
            //originally 0.002
            let moveDuration: Double = 0.001 * Double(distance)
            
            let move = SKAction.move(to: newExitPos,duration: moveDuration)
            let remove = SKAction.removeFromParent()
            let angle = atan2(newExitPos.y - currentPos.y, newExitPos.x - currentPos.x) - CGFloat(M_PI_2)
            tappedBug.zRotation = angle
            tappedBug.run(SKAction.sequence([move, remove]))
            bugTouched = false
            nodeTouched = false
            
            
            ladybugGameLoop()
        }
        
    }
    
    func ladybugCaught(_ ladybug: SKNode, nodeLocation: CGPoint ) {
        
        createAnimation()
        ladybug.name = "ladybug"
        ladybug.run(walkAnimation, withKey: "walkAnimation")
        ladybug.setScale(0.8)
        ladybug.position = nodeLocation
        ladybug.physicsBody?.affectedByGravity = false
        ladybug.physicsBody?.isDynamic = true
        ladybug.physicsBody?.collisionBitMask = 0 // no collisions
        
        SKAction.repeatForever(walkAnimation)
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
           }
}
    
