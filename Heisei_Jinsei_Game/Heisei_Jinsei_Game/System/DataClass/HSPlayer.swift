//
//  HSPlayer.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
 プレイヤーを管理するクラスです。
 Int.max人しか生成できません。
 */
class HSPlayer {
    /// 日本語のプレイヤー名です。
    let name:String
    /// プレーヤーの所持金です。0円以下にはなりません。
    var money:Int = 0{
        didSet{self.money = max(0, self.money)}
    }
    // プレイヤーの全資本です。
    var allEstate:Int{
        return money + currentItems.map{$0.totalValue}.reduce(0, +)
    }
    /// プレイヤーが持っているアイテム一覧です。
    var currentItems = [HSItemStack]()
    
    /// ゴールに到達しているかどうかです。
    var reachesGoal = false
    
    /// プレイヤーの`index`です。同一性保持のためにのみ使います。
    private var index:Int
    
    init(name:String) {
        self.name = name
        self.index =  HSPlayer._lastIndex
        
        HSPlayer._lastIndex += 1
    }
}

extension HSPlayer {
    /// 同一性保持用`Index`
    private static var _lastIndex:Int = 0
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
