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
        return _HSPlayerSquareManager.default.getPosition(of: player)
    }
    
    /// 手番のプレイヤーがルーレットを回します。
    /// 返り値はルーレットの出目です。
    func spinWheel(min:Int = 1, max:Int = 12) -> Int {
        let wheelValue = (min...max).randomElement()!
        _HSPlayerSquareManager.default.didSpinWheel(for: currentPlayer, with: wheelValue)
        
        self._didPlayerPositionChangedByWheel(to: _HSPlayerSquareManager.default.getPosition(of: currentPlayer))

        return wheelValue
    }
    
    /// (アニメーションの都合があると思うので)
    /// ユーザーがイベント発火を確認したら呼び出してください。
    /// アクションを続行します。
    func didUserAcceptEventAction(_ action:HSEraEventAction){
        self._didUserAcceptEventAction(action)
    }
    
    /// `index`番めのマス情報を返します。
    /// 登録されていなかった場合は`nil`を返します。
    func getEraEvent(at index:Int) -> HSEraEvent? {
        return _HSSquareEventManager.default.getEraEvent(at: index)
    }
    
    // ====================================================================================================
    // -----------------------------  HSGameController Private System  ------------------------------------
    // ====================================================================================================
    
    
    /// プレイヤーの位置がサイコロによって変更された時に呼び出してください。
    /// アクションによる変更ではお呼び出さないでください。
    private func _didPlayerPositionChangedByWheel(to position:Int) {
        NotificationCenter.default.post(name: .HSGameControllerDidPlayerPositionChanged, object: currentPlayer)
        
        if let action = _HSSquareEventManager.default.getEraEvent(at: position)?.action{
            self._didOccurActionByWheel(action)
        }
        
    }
    
    /// アクションがサイコロによって発生した時に呼び出してください。
    private func _didOccurActionByWheel(_ action:HSEraEventAction) {
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
            _HSPlayerSquareManager.default.advancePlayer(for: currentPlayer, with: action.skippableSquareCount)
            
        }else if let action = action as? HSEraEventReturnSquareAction{
            _HSPlayerSquareManager.default.advancePlayer(for: currentPlayer, with: -action.returnSquareCount)
            
        }
    }
    
    /// ユーザーの所持金がアクションによって変動した時に呼び出してください。
    private func _didMoneyChangingEventOccur(_ value:Int){
        currentPlayer.money += value
        
        NotificationCenter.default.post(name: .HSGameControllerDidPlayerMoneyChanged, object: currentPlayer)
    }
    
    /// ユーザーの場所がアクションによって変動した時に呼び出してください。
    private func _didPlayerSquareChanginActionOccur(_ value:Int) {
        _HSPlayerSquareManager.default.advancePlayer(for: currentPlayer, with: value)
        
        /// アクションが1度なら
        NotificationCenter.default.post(name: .HSGameControllerDidPlayerPositionChanged, object: currentPlayer)
        /// アクションがn度なら
        // let result = _HSPlayerSquareManager.default.getPosition(of: currentPlayer)
        // self._didPlayerPositionChanged(to: result)
    }
    
    /// 初期化します。
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
    
}

