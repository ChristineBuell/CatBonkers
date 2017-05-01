//
//  GameLoop.swift
//  Cat Bonkers
//
//  Created by Christine Buell on 1/21/17.
//  Copyright © 2017 Christine Buell. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameLoop {
    
    
    func continueLooping (_ moveTo: CGPoint, exitSide: Int) -> (newPosition: CGPoint, newMoveTo: CGPoint, newExitSide: Int) {
        let coordinate = CoordinateLogic()
        let newDirection = exitSide
        let newPosition = moveTo
        var newExitSide: Int =  0
        let newExit = arc4random() % 3 +  1
        var newMoveTo = CGPoint()
        let screenSizeWidth = UIScreen.main.bounds.width
        let screenSizeHeight = UIScreen.main.bounds.height
        
        
        switch newDirection {
        //changed from cases 0-3
        case 0:
            //Enters on top of screen
            //New position to move to
            
            switch newExit{
            case 1:
                //Move to the left of the screen
                newMoveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: screenSizeHeight))
                newExitSide = 1
                break
                
            case 2:
                //Move to the right of screen
                newMoveTo = coordinate.randomPointBetween(CGPoint(x: screenSizeWidth, y: 0), end: CGPoint(x: screenSizeWidth, y: screenSizeHeight))
                newExitSide = 2
                break
                
            case 3:
                //Move to bottom of screen
                newMoveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: 0), end: CGPoint(x:screenSizeWidth, y:0))
                newExitSide = 3
                break
                
            default:
                //Default case
                newMoveTo = CGPoint(x: 1.0, y: 0.0)
                newExitSide = 3
                break
                
                
            }
            
            
        case 1:
            //Enters on left side of screen
            switch newExit{
                
            case 1:
                //Move to top of screen
                newMoveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: screenSizeHeight), end: CGPoint(x: screenSizeWidth, y: screenSizeHeight))
                newExitSide = 0
                break
                
            case 2:
                //Move to the right of screen
                newMoveTo = coordinate.randomPointBetween(CGPoint(x: screenSizeWidth, y: 0), end: CGPoint(x: screenSizeWidth, y: screenSizeHeight))
                newExitSide = 2
                break
                
            case 3:
                //Move to bottom of screen
                newMoveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: 0), end: CGPoint(x:screenSizeWidth, y:0))
                newExitSide = 3
                break
                
            default:
                //Default case
                newMoveTo = CGPoint(x: 1.0, y: 0.0)
                newExitSide = 3
                break
            }
            
        case 2:
            //Enters on right side of screen
            switch newExit{
                
            case 1:
                //Move to top of screen
                newMoveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: screenSizeHeight), end: CGPoint(x: screenSizeWidth, y: screenSizeHeight))
                newExitSide = 0
                break
                
            case 2:
                //Move to the left of the screen
                newMoveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: screenSizeHeight))
                newExitSide = 1
            case 3:
                ///Move to bottom of screen
                newMoveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: 0), end: CGPoint(x:screenSizeWidth, y:0))
                newExitSide = 3
                break
                
            default:
                //Default case
                newMoveTo = CGPoint(x: 1.0, y: 0.0)
                newExitSide = 3
                break
            }
            
            
            
            
        case 3:
            //Enters on bottom of screen
            //New position to move to
            switch newExit{
                
            case 1:
                //Move to top of screen
                newMoveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: screenSizeHeight), end: CGPoint(x: screenSizeWidth, y: screenSizeHeight))
                newExitSide = 0
                break
                
            case 2:
                //Move to the left of the screen
                newMoveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: screenSizeHeight))
                newExitSide = 1
                break
            case 3:
                //Move to the right of screen
                newMoveTo = coordinate.randomPointBetween(CGPoint(x: screenSizeWidth, y: 0), end: CGPoint(x: screenSizeWidth, y: screenSizeHeight))
                newExitSide = 2
                break
                
            default:
                //Default case
                newMoveTo = CGPoint(x: 1.0, y: 0.0)
                newExitSide = 3
                
                break
            }
            
            
        default:
            break
        }
        
        return (newPosition, newMoveTo, newExitSide)
    }
    
}
