//
//  HSItemStack.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

class HSItemStack {
    let item:HSItem
    var count:Int
    
    init(item:HSItem, count:Int = 0) {
        self.item = item
        self.count = count
    }
}