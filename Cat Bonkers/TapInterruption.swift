//
//  TapInterruption.swift
//  Cat Bonkers
//
//  Created by Christine Buell on 1/21/17.
//  Copyright © 2017 Christine Buell. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class TapInterruption {
    
    
    func newExitPoint() -> (moveTo: CGPoint, exitSide: Int) {
        
        let coordinate = CoordinateLogic()
        let screenSizeWidth = UIScreen.main.bounds.width
        let screenSizeHeight = UIScreen.main.bounds.height
        let random = arc4random() % 4 +  1
        var moveTo = CGPoint()
        var exitSide = 0
        
        switch random {
            
        case 1:
            //Moves to the Bottom of screen
            moveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: 0), end: CGPoint(x:screenSizeWidth, y:0))
            exitSide = 3
            break
            
            
        case 2:
            //Moves to Top of screen
            moveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: screenSizeHeight), end: CGPoint(x: screenSizeWidth, y: screenSizeHeight))
            exitSide = 0
            break
            
        case 3:
            //Move to the right of screen
            moveTo = coordinate.randomPointBetween(CGPoint(x: screenSizeWidth, y: 0), end: CGPoint(x: screenSizeWidth, y: screenSizeHeight))
            exitSide = 2
            break
            
        case 4:
            //Move to the left of the screen
            moveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: screenSizeHeight))
            exitSide = 1
            
            break
        default:
            //Default case
            moveTo = CGPoint(x: 1.0, y: 0.0)
            exitSide = 3
            break
            
        }
        return (moveTo, exitSide)
        
    }
    
}





