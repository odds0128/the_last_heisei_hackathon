//
//  _HSSquareEventManager.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/23.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

class HSSquareEventManager {
    // MARK: - P - プロパティー
    private var eraEvents = [HSEraEvent]()
    
    // MARK: - APIs
    /// 全マスのイベントを返します。
    func getAllEraEvents() -> [HSEraEvent]{
        return eraEvents
    }
    
    /// Indexのマスのイベントを返します。
    func getEraEvent(at index:Int) -> HSEraEvent?{
        return eraEvents.at(index)
    }
    
    /// イベントを登録します。
    /// 登録した順にマス目になります。
    func registerEvent(_ event:HSEraEvent){
        eraEvents.append(event)
    }
    
}
