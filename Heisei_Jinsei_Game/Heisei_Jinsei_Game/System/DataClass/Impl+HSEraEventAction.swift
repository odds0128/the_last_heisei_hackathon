//
//  Impl+HSEraEventAction.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/// お金が減ります。
class HSEraEventMoneyReduceAction: HSEraEventBadAction {
    
    let reduceMoneyCount:Int
    
    init(reduceMoneyCount:Int) {
        self.reduceMoneyCount = reduceMoneyCount
        
        super.init()
    }
}

/// お金が増えます。
class HSEraEventMoneyAppendAction: HSEraEventGoodAction {
    
    let appendMoneyCount:Int
    
    init(appendMoneyCount:Int) {
        self.appendMoneyCount = appendMoneyCount
        
        super.init()
    }
}


