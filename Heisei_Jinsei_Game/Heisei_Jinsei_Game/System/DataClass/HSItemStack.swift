//
//  HSItemStack.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
 HSItemをまとめて持てるようになります。
 株券とか、ビットコインとか...? 複数持つものについて
 */
class HSItemStack {
    let item:HSItem
    var count:Int
    
    var totalValue:Int{
        return self.item.price * count
    }
    
    init(item:HSItem, count:Int = 0) {
        self.item = item
        self.count = count
    }
}
