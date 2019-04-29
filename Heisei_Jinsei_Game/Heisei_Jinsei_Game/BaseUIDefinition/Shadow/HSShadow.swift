//
//  Shadow.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/25.
//  Copyright © 2019 yuki. All rights reserved.
//
///通常の影をつける
///================================================
/// 使用例：HSShadow.init(layer: eventButton.layer)
///================================================

import UIKit

class HSShadow {
    static func makeShadow(to layer:CALayer, offset:CGSize = [0, 1], opacity:Float = 0.3, radius:CGFloat = 3) {
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3
    }
}

///内側に影をつける
extension UIImageView {
    func innerShadow() {
        let path = UIBezierPath(rect: CGRect(x: -5.0, y: -5.0, width: self.bounds.size.width + 5.0, height: 5.0 ))
        let innerLayer = CALayer()
        innerLayer.frame = self.bounds
        innerLayer.masksToBounds = true
        innerLayer.shadowColor = UIColor.black.cgColor
        innerLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        innerLayer.shadowOpacity = 0.5
        innerLayer.shadowPath = path.cgPath
        self.layer.addSublayer(innerLayer)
    }
}
