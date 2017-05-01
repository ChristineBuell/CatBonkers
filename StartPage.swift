//
//  StartPage.swift
//  Cat Bonkers
//
//  Created by Christine Buell on 2/11/17.
//  Copyright © 2017 Christine Buell. All rights reserved.
//

import Foundation
import SpriteKit

class StartPage: SKScene {
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "button.atlas")
   // let catPaw = SKSpriteNode()
    let startButton = SKSpriteNode()
    
    
    
    override func didMove(to view: SKView) {
        
        //self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //self.backgroundColor = UIColor(colorLiteralRed: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        
        var startPageBackground = SKSpriteNode(imageNamed: "smallerPavementArtboard.png")
        if UIScreen.main.bounds.width > 1024 {
            startPageBackground = SKSpriteNode(imageNamed: "midPavement.png")
        }
        startPageBackground.position = CGPoint(x: UIScreen.main.bounds.width / 2, y:UIScreen.main.bounds.height / 2 )
        startPageBackground.zPosition = 0

        self.addChild(startPageBackground)
        
        //Draw the name of the game:
        let logoText = SKLabelNode(fontNamed: "GillSans-Bold")
        logoText.text = "Cat Bonkers!"
        logoText.color = UIColor.black
        logoText.position = CGPoint(x: UIScreen.main.bounds.width / 2, y:UIScreen.main.bounds.height / 2 + 250)
        logoText.fontSize = 60
        logoText.zPosition = 11
        self.addChild(logoText)
        //Add another line below:
        let logoTextBottom = SKLabelNode(fontNamed: "GillSans-BoldItalic")
        logoTextBottom.text = "An Interactive Game For Cats"
        logoTextBottom.position = CGPoint(x: UIScreen.main.bounds.width / 2, y:UIScreen.main.bounds.height / 2 + 175)
        logoTextBottom.fontSize = 40
        logoTextBottom.zPosition = 12
        self.addChild(logoTextBottom)
        
        //Build the start game button:
        startButton.texture = textureAtlas.textureNamed("CBStartButton.png")
        startButton.size = CGSize(width: 300, height: 76)
        //Name the start node for touch detection:
        startButton.name = "StartBtn"
        startButton.position = CGPoint(x: UIScreen.main.bounds.width / 2, y:UIScreen.main.bounds.height  / 2 - 250)
        startButton.zPosition = 10
        self.addChild(startButton)
        
//        catPaw.texture = textureAtlas.textureNamed("CatPaw.png")
//        catPaw.position = CGPoint(x: 0, y:UIScreen.main.bounds.height  / 2 - 250)
//        catPaw.zPosition = 14
//        self.addChild(catPaw)
//        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            let nodeTouched = atPoint(location)
            
            if nodeTouched.name == "StartBtn" {
                //Player touched the start text or button node, switch to an
                //instance of the GameScene:
                self.view?.presentScene(GameScene(size: self.size))
            }
        }
    }

}
