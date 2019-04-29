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
    
    ///画像URL
    var imageName: String
    
    init(name:String, price:Int, sellStartingYear:Int, imageName: String) {
        self.name = name
        self.price = price
        self.sellStartingYear = sellStartingYear
        self.imageName = imageName
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
    static let safe = HSItem(name: "金庫", price: 1000, sellStartingYear: 1, imageName: "safe.png")
    static let bit_coin = HSItem(name: "ビットコイン", price: 100, sellStartingYear: 1, imageName: "bit_coin.png")
    static let galapagos_phone = HSItem(name: "ガラケー", price: 15000, sellStartingYear: 1, imageName: "gara_phone.png")
    static let ds = HSItem(name: "DS", price: 20000, sellStartingYear: 1, imageName: "DS.png")
    static let airu = HSItem(name: "アイルー", price: 1000, sellStartingYear: 1, imageName: "airu.png")
    static let devil_airu = HSItem(name: "悪魔アイルー", price: 100000, sellStartingYear: 1, imageName: "devil_airu.png")
    static let game_boy = HSItem(name: "ゲームボーイ", price: 8000, sellStartingYear: 1, imageName: "game_boy.png")
    static let egg_chi = HSItem(name: "たまごっち", price: 1980, sellStartingYear: 1, imageName: "egg_chi")
    static let jobs = HSItem(name: "スティーブ・ジョブズ", price: 500000, sellStartingYear: 1, imageName: "jobs.png")
    static let obuchi = HSItem(name: "小渕恵三", price: 50000, sellStartingYear: 1, imageName: "obuchi.png")
    static let pocket_bell = HSItem(name: "ポケベル", price: 1000, sellStartingYear: 1, imageName: "pocket_bell.png")
    static let psp = HSItem(name: "PSP", price: 20000, sellStartingYear: 1, imageName: "PSP.png")
}


