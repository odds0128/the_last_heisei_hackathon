//
//  Color.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/25.
//  Copyright © 2019 yuki. All rights reserved.
//

///================================================
/// 使用例：view.backgroundColor = HSColor().redColor
///================================================

import UIKit

struct HSColor {
    let greenColor = UIColor(hex: "83DF38")
    let redColor = UIColor(hex: "FF004A")
    let blueColor = UIColor(hex: "0066FF")
    let yellowColor = UIColor(hex: "FFC500")
    let grayColor = UIColor(hex: "D8D8D8")
    let orangeColor = UIColor(hex: "FF7307")
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let v = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
}
