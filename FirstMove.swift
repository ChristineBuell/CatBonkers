//
//  FirstMove.swift
//  Cat Bonkers
//
//  Created by Christine Buell on 1/21/17.
//  Copyright © 2017 Christine Buell. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class FirstMove {
    
    func firstCoordinates() -> (position: CGPoint, moveTo: CGPoint, exitSide: Int){
        let coordinate = CoordinateLogic()
        let screenSizeWidth = UIScreen.main.bounds.width
        let screenSizeHeight = UIScreen.main.bounds.height
        let random = arc4random() % 4 +  1
        var position = CGPoint()
        var moveTo = CGPoint()
        var exitSide = 1
        
        switch random {
            
        //Top
        case 1:
            
            position = coordinate.randomPointBetween(CGPoint(x: 0, y: screenSizeHeight), end: CGPoint(x: screenSizeWidth, y: screenSizeHeight))
            
            //Move to opposite side
            moveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: 0), end: CGPoint(x:screenSizeWidth, y:0))
            exitSide = 3
            //return (position, moveTo, exitSide)
            break
            
            
        //Left
        case 2:
            position = coordinate.randomPointBetween(CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: screenSizeHeight))
            
            //Move to opposite side
            moveTo = coordinate.randomPointBetween(CGPoint(x: screenSizeWidth, y: 0), end: CGPoint(x: screenSizeWidth, y: screenSizeHeight))
            exitSide = 2
            //return (position, moveTo, exitSide)
            
            break
            
        //Right
        case 3:
            position = coordinate.randomPointBetween(CGPoint(x: screenSizeWidth, y: 0), end: CGPoint(x: screenSizeWidth, y: screenSizeHeight))
            
            //Move to opposite side
            moveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: screenSizeHeight))
            exitSide = 1
            
            
            break
            
            //Bottom
            
        case 4:
            position = coordinate.randomPointBetween(CGPoint(x: 0, y: 0), end: CGPoint(x: screenSizeWidth, y: 0))
            
            //Move to opposite side
            moveTo = coordinate.randomPointBetween(CGPoint(x: 0, y: screenSizeHeight), end: CGPoint(x: screenSizeWidth, y: screenSizeHeight))
            exitSide = 0
            //return (position, moveTo, exitSide)
            break
            
            
        default:
            break
        }
        return (position, moveTo, exitSide)
        
    }
}

