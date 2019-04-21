//
//  HSGameController.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
 
 HSGameControllerはシングルトンを提供しますが、最初から初期化されていません。
 Playerがゲームをスタートした後に
 HSGameController::initiarize(_:) で初期化する必要がありあマス。
 --通知--
 HSGameControllerは以下の通知を投げます。ViewModelはこれを受け取って、Viewに状態を反映させてください。
 `(object:...)`は `Notification`の`object`プロパティの中身です。
 
 - HSGameControllerDidChangePlayerPosition (object: HSPlayer)
 - HSGameControllerDidEraEventActionOccur (object: HSEventAction)
 
 */
class HSGameController {
    static var `default`:HSGameController? = nil
    static func initiarize(with gamingPlayers:[HSPlayer]){
        
    }
    
    /// 手番のプレイヤーです。
    var currentPlayer:HSPlayer
    
    /// ゲーム中のプレイヤーです。
    var gamingPlayers:[HSPlayer]
    
    init(gamingPlayers:[HSPlayer]) {
        precondition(gamingPlayers.count >= 2, "ゲームプレイヤーは2人以上必要です。")
        
        self.gamingPlayers = gamingPlayers
        self.currentPlayer = gamingPlayers[0]
    }
    
    /// 手番のプレイヤーがルーレットを回します。
    func spinWheel(){
        
    }
}
