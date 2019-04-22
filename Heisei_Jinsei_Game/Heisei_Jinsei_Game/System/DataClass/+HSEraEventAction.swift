//
//  Impl+HSEraEventAction.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/// お金が減ります。
/// 強制です。
class HSEraEventMoneyReduceAction: HSEraEventAction {
    
    let reduceMoneyCount:Int
    
    init(reduceMoneyCount:Int) {
        self.reduceMoneyCount = reduceMoneyCount
        
        super.init(eventType: .bad, description: "所持金を\(reduceMoneyCount)円失う。")
    }
}

/// お金が増えます。
/// 強制です。
class HSEraEventMoneyAppendAction: HSEraEventAction {
    
    let appendMoneyCount:Int
    
    init(appendMoneyCount:Int) {
        self.appendMoneyCount = appendMoneyCount
        
        super.init(eventType: .good, description: "所持金が\(appendMoneyCount)増える。")
    }
}

/// アイテムが手に入れられます。
/// 選択式です。View-ViewModel側で調整してください。
class HSEraEventItemGettingAction: HSEraEventAction {
    let gettableItem:HSItem
    
    init(item:HSItem) {
        self.gettableItem = item
        
        super.init(eventType: .good, description: "\(item.name)を\(item.price)円でゲットできる。")
    }
}

/// アイテムが複数手に入れられます。
/// 選択式です。View-ViewModel側で調整してください。
class HSEraEventMultipulItemGettingAction: HSEraEventAction {
    let gettableItem:HSItem
    let maxGettingCount:Int
    
    init(item:HSItem, max:Int) {
        self.gettableItem = item
        self.maxGettingCount = max
        
        super.init(eventType: .good, description: "\(item.name)を\(item.price)円で\(max)個までゲットできる。")
    }
}

/// 先のマスまで飛べます。
/// 選択式です。View-ViewModel側で調整してください。
class HSEraEventSkipSquareAction: HSEraEventAction{
    let skippableSquareCount:Int
    
    init(skippableSquareCount:Int) {
        self.skippableSquareCount = skippableSquareCount
        
        super.init(eventType: .good, description: "\(skippableSquareCount)マス先まで進める。")
    }
}

/// マスを戻らされます。
/// 強制です。
class HSEraEventReturnSquareAction: HSEraEventAction{
    let returnSquareCount:Int
    
    init(returnSquareCount:Int) {
        self.returnSquareCount =  returnSquareCount
        
        super.init(eventType: .bad, description: "\(returnSquareCount)マス戻る。")
    }
}
