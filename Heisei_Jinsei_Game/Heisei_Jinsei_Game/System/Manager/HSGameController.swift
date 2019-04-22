//
//  HSGameController.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
 このクラスが、ViewModelとの通信のほとんどを行います。
 （多分このクラスだけでゲームができる）
 
 HSGameControllerはシングルトンを提供しますが、最初から初期化されていません。
 Playerがゲームをスタートした後に
 HSGameController::initiarize(_:) で初期化する必要がありあます。
 
 --通知--
 HSGameControllerは以下の通知を投げます。ViewModelはこれを受け取って、Viewに状態を反映させてください。
 `(object:...)`は `Notification`の`object`プロパティの中身です。
 
 - HSGameControllerDidChangePlayerPosition (object: HSPlayer)
 - HSGameControllerDidEraEventActionOccur (object: HSEventAction)
 
 */
class HSGameController {
    // MARK: - HSGameController Properties
    /// 手番のプレイヤーです。
    var currentPlayer:HSPlayer
    /// ゲーム中のプレイヤーです。
    var gamingPlayers:[HSPlayer]
    
    
    // MARK: - HSGameController Msthods
    
    /// マスにイベントを追加します。
    /// 連続的に`index`を指定してください。じゃないとお血ます。
    func registerSquare(index:Int, event:HSEraEvent){
        
    }
    /// 手番のプレイヤーがルーレットを回します。
    func spinWheel() {
        HSPlayerSquareManager.default.spinWheel(for: currentPlayer)
    }
    /// プレイヤーの場所を返します。
    func getPlayerPosition(_ player:HSPlayer) -> Int {
        return HSPlayerSquareManager.default.getPosition(of: player)
    }
    
    private init(gamingPlayers:[HSPlayer]) {
        precondition(gamingPlayers.count >= 2, "ゲームプレイヤーは2人以上必要です。")
        
        self.gamingPlayers = gamingPlayers
        self.currentPlayer = gamingPlayers[0]
    }
}
extension HSGameController {
    static var `default`:HSGameController! = nil
    
    static func initiarize(with gamingPlayers:[HSPlayer]){
        HSGameController.default = HSGameController(gamingPlayers: gamingPlayers)
    }
    
}
