//
//  HSEraEventAction.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
 時代アクションのRootクラスです。
 */
class HSEraEventAction {
    let eventType:EventType
    
    enum EventType {
        case bad
        case good
    }
    
    
    init(eventType:EventType) {
        self.eventType = eventType
    }
}

/// 悪いアクションです。
class HSEraEventBadAction:HSEraEventAction {
    init() {
        super.init(eventType: .bad)
    }
}

/// 良いアクションです。
class HSEraEventGoodAction:HSEraEventAction {
    init() {
        super.init(eventType: .good)
    }
}
