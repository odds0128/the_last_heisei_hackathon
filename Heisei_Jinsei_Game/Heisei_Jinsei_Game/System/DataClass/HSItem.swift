//
//  HSItem.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
 プレイヤーが持つアイテムを管理するクラスです。
 各アイテムにつき実態は1つのみとします。
 HSItem.(アイテム)でアクセスしてください。
 複数個のアイテムを持つ際は`HSItemStack`を利用してください。
 */
class HSItem {
    /// 日本語の表示名です。
    let name:String
    
    /// 価格です。
    var price:Int
    
    /// 売り始める時期
    var sellStartingYear:Int
    
    fileprivate init(name:String, price:Int, sellStartingYear:Int) {
        self.name = name
        self.price = price
        self.sellStartingYear = sellStartingYear
    }
}

/// Array::containsなどが使えるようにするための拡張です。
/// 参照の同一比較のみを行います。
extension HSItem: Equatable{
    static func == (left:HSItem, right:HSItem) -> Bool{
        return left === right
    }
}

/// 各アイテムの参照はここに持ちます。
extension HSItem {
    static let safe = HSItem(name: "金庫", price: 1000, sellStartingYear: 1)
}


