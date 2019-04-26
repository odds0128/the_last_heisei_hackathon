//
//  HSEraEventAction.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
 アクションのRootクラスです。
 各アクションはこのクラスを継承してください。
 */
class HSEraEventAction {
    /// イベントの種類です。`.bad`ならマスが赤く、`.good`ならマスが緑になります。
    let eventType:EventType
    
    /// イベントの日本語の説明です。
    let description:String
    
    init(eventType:EventType, description:String) {
        self.eventType = eventType
        self.description = description
        
    }
    
    enum EventType {
        /// マスが赤くなります。
        case bad
        /// マスが緑になります。
        case good
        /// 特殊イベントです。
        case special
        /// ゴールマス用です。
        case goal
    }
}
