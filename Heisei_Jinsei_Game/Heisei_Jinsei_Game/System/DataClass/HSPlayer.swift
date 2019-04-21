//
//  HSPlayer.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

private var HSPlayerCurrentLastIndex = 0

/**
 プレイヤーを管理するクラスです。
 **4人までしか生成できません！**
 */
struct HSPlayer {
    /// 日本語のプレイヤー名です。
    let name:String
    /// プレーヤーの所持金です。
    var money:Int = 0
    /// プレイヤーの家族数です。
    var familyCount:Int = 0
    /// プレイヤーが持っているアイテム一覧です。
    //var currentItems = [HSItemStack]()
    /// プレイヤーの色です。生成時に自動的に決定されます。
    let color:Color
    enum Color:Int { case red=0, blue=1, green=2, yellow=3}
    
    /// プレイヤーの`index`です。同一性保持のためにのみ使います。
    fileprivate var index:Int
    
    init(name:String) {
        precondition(HSPlayerCurrentLastIndex < 4 , "プレイヤーは4人以上生成できません。")
        self.name = name
        self.index =  HSPlayerCurrentLastIndex
        self.color = Color(rawValue: HSPlayerCurrentLastIndex)!
        
        HSPlayerCurrentLastIndex += 1
    }
}

extension HSPlayer: Equatable {
    static func == (left:HSPlayer, right:HSPlayer) -> Bool{
        return left.index == right.index
    }
}

extension HSPlayer: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.index)
    }
}
