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
 詳細は System/README.md を参照してください。
 
 */
class HSGameController {
    // MARK: - HSGameController Properties
    
    /// 現在手番のプレイヤーです。
    private(set) var currentPlayer:HSPlayer
    /// ゲーム中のプレイヤーです。
    private(set) var gamingPlayers:[HSPlayer]
    
    // MARK: - HSGameController Methods
    /// プレイヤーの場所を返します。
    func getPlayerPosition(_ player:HSPlayer) -> Int {
        return self.playerManager.getPosition(of: player)
    }
    
    /// 手番のプレイヤーがルーレットを回します。
    /// 返り値はルーレットの出目です。
    func spinWheel(min:Int = 1, max:Int = 12) -> Int {
        let wheelValue = (min...max).randomElement()!
        self.playerManager.didSpinWheel(for: currentPlayer, with: wheelValue)
        
        self._didPlayerPositionChangedByWheel(to: self.playerManager.getPosition(of: currentPlayer))

        return wheelValue
    }
    
    /// 手番のプレイヤーを強制的に進めます。
    /// 以降の動作は普通にルーレットを回した場合と同様です。
    func advancePlayer(by value:Int){
        self.spinWheel(min: value, max: value)
    }
    
    /// アニメーションが完了したら呼び出してください。
    /// マスのアクション・操作ユーザー更新を行います。
    /// アクションによるAnimation後も再度呼び出してください。
    func didAnimationEnd(){
        if let watingAction = watingAction{
            self.watingAction = nil
            self._didUserAcceptEventAction(watingAction)
        }else{
            self.changeTurn()
        }
    }
    
    /// `index`番めのマス情報を返します。
    /// 登録されていなかった場合は`nil`を返します。
    func getEraEvent(at index:Int) -> HSEraEvent? {
        return self.eventManager.getEraEvent(at: index)
    }
    
    /// 全マスのイベントを返します。
    func getAllEraEvents() -> [HSEraEvent]{
        return self.eventManager.getAllEraEvents()
    }
    
    // ====================================================================================================
    // -----------------------------  HSGameController Private System  ------------------------------------
    // ====================================================================================================
    
    /// プレーヤーマネージャーです。マス目一の管理をします。
    private let playerManager:HSPlayerSquareManager
    
    /// イベントマネージャーです。
    private let eventManager:HSSquareEventManager
    
    /// 待機中のアクションです。
    private var watingAction:HSEraEventAction?
    
    /// プレイヤーの位置がサイコロによって変更された時に呼び出してください。
    /// アクションによる変更ではお呼び出さないでください。
    private func _didPlayerPositionChangedByWheel(to position:Int) {
        NotificationCenter.default.post(name: .HSGameControllerDidPlayerPositionChanged, object: currentPlayer)
        
        if let action = self.eventManager.getEraEvent(at: position).action{
            self._didOccurActionByWheel(action)
        }
    }
    
    private func changeTurn(){
        guard let indexOfCurrentPlayer = gamingPlayers.firstIndex(of: currentPlayer) else {fatalError("存在しないユーザーが指定されました。")}
        let nextIndex = (indexOfCurrentPlayer + 1) % gamingPlayers.count
        
        currentPlayer = gamingPlayers[nextIndex]
        
        NotificationCenter.default.post(name: .HSGameControllerDidCurrentPlayerChanged, object: currentPlayer)
    }
    
    /// アクションがサイコロによって発生した時に呼び出してください。
    private func _didOccurActionByWheel(_ action:HSEraEventAction) {
        self.watingAction = action
        NotificationCenter.default.post(name: .HSGameControllerDidEventActionOccur, object: action)
    }
    
    /// ユーザーがイベント発火を確認したら呼び出してください。
    /// アクションを続行します。
    private func _didUserAcceptEventAction(_ action:HSEraEventAction){
        if let action = action as? HSEraEventMoneyReduceAction {
            _didMoneyChangingEventOccur(-action.reduceMoneyCount)
            
        }else if let action = action as? HSEraEventMoneyAppendAction {
            _didMoneyChangingEventOccur(action.appendMoneyCount)
            
        }else if let action = action as? HSEraEventSkipSquareAction {
            self.playerManager.advancePlayer(for: currentPlayer, with: action.skippableSquareCount)
            
        }else if let action = action as? HSEraEventReturnSquareAction{
            self.playerManager.advancePlayer(for: currentPlayer, with: -action.returnSquareCount)
            
        }
    }
    
    /// ユーザーの所持金がアクションによって変動した時に呼び出してください。
    private func _didMoneyChangingEventOccur(_ value:Int){
        currentPlayer.money += value
        
        NotificationCenter.default.post(name: .HSGameControllerDidPlayerMoneyChanged, object: currentPlayer)
    }
    
    /// ユーザーの場所がアクションによって変動した時に呼び出してください。
    private func _didPlayerSquareChanginActionOccur(_ value:Int) {
        self.playerManager.advancePlayer(for: currentPlayer, with: value)
        
        NotificationCenter.default.post(name: .HSGameControllerDidPlayerPositionChanged, object: currentPlayer)
    }
    
    /// 初期化します。
    init(playerManager:HSPlayerSquareManager, eventManager:HSSquareEventManager) {
        self.gamingPlayers = playerManager.players
        self.currentPlayer = playerManager.players[0]
        self.playerManager = playerManager
        self.eventManager = eventManager
    }
}

extension Notification.Name{
    /// 止まったマスにイベントアクションが発生した時に発火します。
    /// `Notification::object`は`HSEventAction`です。
    static let HSGameControllerDidEventActionOccur = Notification.Name("__HSGameControllerDidEventActionOccur__")
    
    /// プレイヤーの所持金が変化した時に発火します。
    /// `Notification::object`は`HSPlayer`です。
    static let HSGameControllerDidPlayerMoneyChanged = Notification.Name("__HSGameControllerDidPlayerMoneyChanged__")
    
    /// プレイヤーの場所が変化した時に発火します。
    /// `Notification::object`は`HSPlayer`です。
    static let HSGameControllerDidPlayerPositionChanged = Notification.Name("__HSGameControllerDidPlayerPositionChanged__")
    
    ///   操作ユーザーが更新された時に発火します。
    /// `Notification::object`は更新後の`HSPlayer`です。
    static let HSGameControllerDidCurrentPlayerChanged = Notification.Name("__HSGameControllerDidCurrentPlayerChanged__")
    
}

