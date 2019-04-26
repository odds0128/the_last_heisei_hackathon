//
//  HSPlayerSquareManager.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
 HSPlayerSquareManager: プレイヤーの位置情報管理をします。
  */
class HSPlayerSquareManager{

    var players:[HSPlayer]
    // MARK: - HSPlayerSquareManager Priavate Properties
    private var playerPositions = [HSPlayer:Int]()
    private var lastSquareIndex:Int
    
    // MARK: - HSPlayerSquareManager APIs
    
    /// ルーレットの結果を反映します。
    func didSpinWheel(for player:HSPlayer,with wheelValue:Int) {
        let newPlayerPosition = getPosition(of: player) + wheelValue
        
        self._setPosition(for: player, to: newPlayerPosition)
    }
    
    /// プレイヤーを進めます。
    func advancePlayer(for player:HSPlayer, with advanceCount:Int){
        let newPlayerPosition = getPosition(of: player) + advanceCount
        
        self._setPosition(for: player, to: newPlayerPosition)
    }
    
    /// 現在のプレイヤーの場所を返します。
    func getPosition(of player:HSPlayer) -> Int{
        return playerPositions[player]!
    }
    
    // MARK: - HSPlayerSquareManager Private Mathods
    private func _setPosition(for player:HSPlayer, to value:Int) {
        self.playerPositions[player] = min(lastSquareIndex, value)
    }
    
    init(gamingPlayers:[HSPlayer], lastSquareIndex:Int) {
        self.players = gamingPlayers
        self.lastSquareIndex = lastSquareIndex
        
        for player in gamingPlayers{
            self.playerPositions[player] = 0
        }
    }
}
