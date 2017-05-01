//
//  CoordinateLogic.swift
//  Cat Bonkers
//
//  Created by Christine Buell on 1/21/17.
//  Copyright © 2017 Christine Buell. All rights reserved.
//

import Foundation
import UIKit

class CoordinateLogic {
    
    func randomBetweenNumbers(_ firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    //Helper method for spawning a point along the screen borders. This will not work for diagonal lines.
    func randomPointBetween(_ start:CGPoint, end:CGPoint)->CGPoint{
        return CGPoint(x: randomBetweenNumbers(start.x, secondNum: end.x), y: randomBetweenNumbers(start.y, secondNum: end.y))
        
    }
}
