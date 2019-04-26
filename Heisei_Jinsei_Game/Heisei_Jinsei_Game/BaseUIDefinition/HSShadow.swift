//
//  Shadow.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/25.
//  Copyright © 2019 yuki. All rights reserved.
//

///================================================
/// 使用例：HSShadow.init(layer: eventButton.layer)
///================================================

import UIKit

class HSShadow {
    
    init(layer: CALayer) {
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3
    }
}
