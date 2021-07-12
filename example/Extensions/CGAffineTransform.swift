//
//  CGAffineTransform.swift
//  example
//
//  Created by B1591 on 2021/4/27.
//

import UIKit

extension CGAffineTransform {

    mutating func rotate(by rotationAngle: CGFloat) {
        self = self.rotated(by: rotationAngle)
    }

    mutating func scale(by scalingFactor: CGFloat) {
        self = self.scaledBy(x: scalingFactor, y: scalingFactor)
    }

}
