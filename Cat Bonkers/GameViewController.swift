//
//  GameViewController.swift
//  Cat Bonkers
//
//  Created by Christine Buell on 1/21/17.
//  Copyright © 2017 Christine Buell. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let startPage = StartPage()
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        startPage.size = view.bounds.size
        skView.presentScene(startPage)
        

    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let scene = GameScene(size: view.bounds.size)
//        let skView = view as! SKView
//              
//        skView.ignoresSiblingOrder = true
//        scene.scaleMode = .aspectFill
//        skView.presentScene(scene)
//        
    
        
        
          }
//    //added for start page

//    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}






