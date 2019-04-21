//
//  HSPlayerTroutManager.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
 HSPlayerTroutManager: プレイヤーの位置情報管理をします。
 シングルトンとして、`default`を持ちます。
 
 --通知--
 HSPlayerTroutManagerは以下の通知を投げます。ViewModelはこれを受け取って、Viewに状態を反映させてください。
 `(object:...)`は `Notification`の`object`プロパティの中身です。
 
 - HSPlayerTroutManagerPlayerPositionDidChange (object: HSPlayer)
 */
class HSPlayerTroutManager{
    // MARK: - Singleton
    static let `default` = HSPlayerTroutManager()
    
    // MARK: - HSPlayerTroutManager Priavate Properties
    private var playerPositions = [HSPlayer:Int]()
    
    // MARK: - HSPlayerTroutManager APIs
    /**
     ルーレットを回します。
     具体的には1...12の乱数を生成し、PlayerPositionに足します。
     */
    func spinWheel(for player:HSPlayer) {
        let wheelValue = _generateRandomNumber()
        let newPlayerPosition = getPosition(of: player) + wheelValue
        
        self._setPosition(for: player, to: newPlayerPosition)
    }
    
    /// プレイヤーを進めます。
    func advancePlayer(for player:HSPlayer, with advanceCount:Int){
        let newPlayerPosition = getPosition(of: player) + advanceCount
        
        self._setPosition(for: player, to: newPlayerPosition)
    }
    
    /// 現在のプレイヤーの場所を返しあす。
    func getPosition(of player:HSPlayer) -> Int{
        self._initiarizePlayerIfNeeded(player)
        
        return playerPositions[player]!
    }
    
    
    // MARK: - HSPlayerTroutManager Private Mathods
    private func _setPosition(for player:HSPlayer, to value:Int) {
        self.playerPositions[player] = value
    }
    
    /// 必要ならばPlayerを初期化します。
    private func _initiarizePlayerIfNeeded(_ player:HSPlayer){
        if playerPositions[player] == nil{
            playerPositions[player] = 0
        }
    }
    /// 1...12までの乱数を返します。
    private func _generateRandomNumber() -> Int{
        return (1...12).randomElement()!
    }
}
