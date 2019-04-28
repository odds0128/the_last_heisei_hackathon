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
    
    /// ゲームが終了しているかどうかです。
    var isGameEnded:Bool {
        return gamingPlayers.allSatisfy{$0.reachesGoal}
    }
    
    // MARK: - HSGameController Methods
    /// プレイヤーの場所を返します。
    func getPlayerPosition(_ player:HSPlayer) -> Int {
        return self.playerManager.getPosition(of: player)
    }
    
    /// プレイヤーのIndexを返します。
    func getPlayerIndex(_ player:HSPlayer) -> Int {
        guard let index = self.gamingPlayers.firstIndex(of: player) else { fatalError("存在しないプレイヤーが指定されました。") }
        return index
    }
    
    /// 手番のプレイヤーがルーレットを回します。
    /// 返り値はルーレットの出目です。
    func spinWheel(min:Int = 1, max:Int = 12) -> Int {
        let wheelValue = (min...max).randomElement()!
        self.playerManager.didSpinWheel(for: currentPlayer, with: wheelValue)
        
        isWatingRouletteAnimation = true
        
        return wheelValue
    }
    
    /// 手番のプレイヤーを強制的に進めます。
    /// 以降の動作は普通にルーレットを回した場合と同様です。
    func advancePlayer(by value:Int){
        _=self.spinWheel(min: value, max: value)
    }
    
    /// アニメーションが完了したら呼び出してください。
    /// マスのアクション・操作ユーザー更新を行います。
    /// アクションによるAnimation後も再度呼び出してください。
    func animationDidEnd(){
        // ルーレット待機後なら
        if isWatingRouletteAnimation {
            isWatingRouletteAnimation = false
            self._willPlayerPositionChangedByWheel(to: self.playerManager.getPosition(of: currentPlayer))
            return
        }
        
        // ルーレットによる移動完了後なら
        if isWatingFirstPlayerMoving {
            isWatingFirstPlayerMoving = false
            if let action = self.eventManager.getEraEvent(at: self.playerManager.getPosition(of: currentPlayer)).action{
                self._didOccurActionByWheel(action)
                return
            }
        }
        
        // アクション認証待機後なら
        if let watingAction = watingAction{
            self.watingAction = nil
            self._didUserAcceptEventAction(watingAction)
            return
        }
        
        // それ以外なら、順番交代
        self.changeTurn()
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
    
    // ===========================================================================
    // ------------------  HSGameController Private Properties -------------------
    
    /// プレーヤーマネージャーです。マス目一の管理をします。
    private let playerManager:HSPlayerSquareManager
    
    /// イベントマネージャーです。
    private let eventManager:HSSquareEventManager
    
    /// ゴールに到着したプレイヤーです。
    private var reachedGoalPlayers = [HSPlayer]()
    
    // ------------- アニメーション待機用フラグ --------------
    
    /// ルーレット待機中フラグ
    private var isWatingRouletteAnimation = false
    /// ルーレットによる移動の待機フラグ
    private var isWatingFirstPlayerMoving = false
    /// 待機中のアクションです。
    private var watingAction:HSEraEventAction?
    
    // ===========================================================================
    // -------------------  HSGameController Private Methods ---------------------
    
    /// プレイヤーの位置がサイコロによって変更された時に呼び出してください。
    /// アクションによる変更ではお呼び出さないでください。
    private func _willPlayerPositionChangedByWheel(to position:Int) {
        self._willPlayerSquareChanged()
        
        isWatingFirstPlayerMoving = true
    }
    
    private func changeTurn(){
        guard let currentPlayerIndex = gamingPlayers.firstIndex(of: currentPlayer) else {
            fatalError("存在しないぴプレイヤーが指定されました。")
        }
        if isGameEnded{
            return _checkIfGameEnded()
        }
        
        let nextIndex = (currentPlayerIndex + 1) % gamingPlayers.count
        
        func _changeTurn(index:Int) {
            let nextEstimatedPlayer = gamingPlayers[index]
            
            if nextEstimatedPlayer.reachesGoal {
                return _changeTurn(index: index + 1)
            }
            currentPlayer = nextEstimatedPlayer
        }
        
        _changeTurn(index: nextIndex)
        
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
            self._didMoneyChangingEventOccur(-action.reduceMoneyCount)
            
        }else if let action = action as? HSEraEventMoneyAppendAction {
            self._didMoneyChangingEventOccur(action.appendMoneyCount)
            
        }else if let action = action as? HSEraEventSkipSquareAction {
            self._didPlayerSquareChanginActionOccur(action.skippableSquareCount)
            
        }else if let action = action as? HSEraEventReturnSquareAction{
            self._didPlayerSquareChanginActionOccur(-action.returnSquareCount)
            
        }else if let _ = action as? HSEraEventPlayerGoalAction {
            self._didPlayerReachesGoal(currentPlayer)
            
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
        
        self._willPlayerSquareChanged()
    }
    
    /// プレイヤーの場所が変更された場合に呼び出してください。
    /// ルーレットびによっても・アクションによっても
    private func _willPlayerSquareChanged(){
        NotificationCenter.default.post(name: .HSGameControllerDidPlayerPositionChanged, object: currentPlayer)
        
        /// 2重チェックになるが...問題はない。
        if let action = getEraEvent(at: getPlayerPosition(currentPlayer))?.action as? HSEraEventPlayerGoalAction{
            self.watingAction = action
        }
    }
    
    /// プレイヤーがゴールに到達した場合に呼び出してください。
    private func _didPlayerReachesGoal(_ player:HSPlayer) {
        player.reachesGoal = true
        
        NotificationCenter.default.post(name: .HSGameControllerDidPlayerReachedTheGoal, object: player)
        
        _checkIfGameEnded()
    }
    private func _checkIfGameEnded(){
        if gamingPlayers.allSatisfy({$0.reachesGoal}){
            NotificationCenter.default.post(name: .HSGameControllerDidGameEnd, object: nil)
        }
    }
    /// 初期化します。
    init(playerManager:HSPlayerSquareManager, eventManager:HSSquareEventManager) {
        self.gamingPlayers = playerManager.players
        self.currentPlayer = playerManager.players[0]
        self.playerManager = playerManager
        self.eventManager = eventManager
    }
}

// MARK: - 通知用拡張
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
    
    /// プレイヤーがゴールに到達した時発火します。
    /// `Notification::object`はゴールした`HSPlayer`です。
    static let HSGameControllerDidPlayerReachedTheGoal = Notification.Name("__HSGameControllerDidPlayerReachedTheGoal__")
    
    /// ゲームが終了した時に発火します。
    /// `Notification::object`は`nil`です。
    static let HSGameControllerDidGameEnd = Notification.Name("__HSGameControllerDidGameEnd__")
    
}

