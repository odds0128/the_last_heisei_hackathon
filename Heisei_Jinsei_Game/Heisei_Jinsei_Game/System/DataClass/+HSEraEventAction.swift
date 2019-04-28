//
//  Impl+HSEraEventAction.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

class HSEraEventPlayerGoalAction: HSEraEventAction {
    
    init() {
        super.init(eventType: .goal, description: "ゴール!")
    }
}

/// お金が減ります。
class HSEraEventMoneyReduceAction: HSEraEventAction {
    
    let reduceMoneyCount:Int
    
    init(title:String,reduceMoneyCount:Int) {
        self.reduceMoneyCount = reduceMoneyCount
        
        super.init(eventType: .bad,title: title, description: "所持金を\(reduceMoneyCount)円失う。")
    }
}

/// お金が増えます。
class HSEraEventMoneyAppendAction: HSEraEventAction {
    
    let appendMoneyCount:Int
    
    init(title:String, appendMoneyCount:Int) {
        self.appendMoneyCount = appendMoneyCount
        
        super.init(eventType: .good,title:title, description: "所持金が\(appendMoneyCount)円増える。")
    }
}

/// アイテムが手に入れられます。
class HSEraEventItemGettingAction: HSEraEventAction {
    let gettableItem:HSItem
    
    init(title:String, item:HSItem) {
        self.gettableItem = item
        
        super.init(eventType: .good,title:title, description: "\(item.name)をゲットできる。")
    }
}

/// 先のマスまで飛べます。
class HSEraEventSkipSquareAction: HSEraEventAction{
    let skippableSquareCount:Int
    
    init(title:String, skippableSquareCount:Int) {
        self.skippableSquareCount = skippableSquareCount
        
        super.init(eventType: .good,title:title, description: "\(skippableSquareCount)マス先まで進める。")
    }
}

/// マスを戻らされます。
class HSEraEventReturnSquareAction: HSEraEventAction{
    let returnSquareCount:Int
    
    init(title: String, returnSquareCount:Int) {
        self.returnSquareCount =  returnSquareCount
        
        super.init(eventType: .bad,title:title, description: "\(returnSquareCount)マス戻る。")
    }
}
