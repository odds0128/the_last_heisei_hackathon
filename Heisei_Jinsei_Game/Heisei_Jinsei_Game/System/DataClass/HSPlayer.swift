//
//  HSPlayer.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation


struct HSPlayer {
    /// 日本語のプレイヤー名です。
    var name:String
    /// プレーヤーの所持金です。
    var money:Int = 0
    /// プレイヤーの家族数です。
    var familyCount:Int = 0
    
    fileprivate var index:Int
    
    init(name:String) {
        self.name = name
    }
}

extension HSPlayer {
    
}
