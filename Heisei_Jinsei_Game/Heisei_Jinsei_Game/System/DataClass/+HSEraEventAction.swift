//
//  Impl+HSEraEventAction.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/// お金が減ります。
class HSEraEventMoneyReduceAction: HSEraEventAction {
    
    let reduceMoneyCount:Int
    
    init(reduceMoneyCount:Int) {
        self.reduceMoneyCount = reduceMoneyCount
        
        super.init(eventType: .bad, description: "所持金を\(reduceMoneyCount)円失う。")
    }
}

/// お金が増えます。
class HSEraEventMoneyAppendAction: HSEraEventAction {
    
    let appendMoneyCount:Int
    
    init(appendMoneyCount:Int) {
        self.appendMoneyCount = appendMoneyCount
        
        super.init(eventType: .good, description: "所持金が\(appendMoneyCount)円増える。")
    }
}

/// アイテムが手に入れられます。
class HSEraEventItemGettingAction: HSEraEventAction {
    let gettableItem:HSItem
    
    init(item:HSItem) {
        self.gettableItem = item
        
        super.init(eventType: .good, description: "\(item.name)をゲットできる。")
    }
}

/// 先のマスまで飛べます。
class HSEraEventSkipSquareAction: HSEraEventAction{
    let skippableSquareCount:Int
    
    init(skippableSquareCount:Int) {
        self.skippableSquareCount = skippableSquareCount
        
        super.init(eventType: .good, description: "\(skippableSquareCount)マス先まで進める。")
    }
}

/// マスを戻らされます。
class HSEraEventReturnSquareAction: HSEraEventAction{
    let returnSquareCount:Int
    
    init(returnSquareCount:Int) {
        self.returnSquareCount =  returnSquareCount
        
        super.init(eventType: .bad, description: "\(returnSquareCount)マス戻る。")
    }
}
