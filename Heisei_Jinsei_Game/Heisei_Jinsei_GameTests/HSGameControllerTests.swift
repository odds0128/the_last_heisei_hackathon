//
//  _HSGameControllerTests.swift
//  Heisei_Jinsei_GameTests
//
//  Created by yuki on 2019/04/23.
//  Copyright © 2019 yuki. All rights reserved.
//

import XCTest
@testable import Heisei_Jinsei_Game

class HSGameControllerTests: XCTestCase {
    func createPlayerManager() -> HSPlayerSquareManager {
        let alice = HSPlayer(name: "Alice")
        let bob = HSPlayer(name: "Bob")
        let cathey = HSPlayer(name: "Cathey")
        
        let playerManager = HSPlayerSquareManager(gamingPlayers: [alice, bob, cathey], lastSquareIndex: 50)
        
        return playerManager
    }
    func createEventManager() -> HSSquareEventManager {
        let eventManager = HSSquareEventManager()
        
        /// 仮初期化
        var events = (0...50).map{i in
            HSEraEvent(title: "タイトル1", heiseiYear: (i/4), eventDescription: "説明", imageName: "nil", action: nil)
        }
        // ます2を飛ばす様にする。
        events[2].action = HSEraEventSkipSquareAction(title:"", skippableSquareCount: 1)
        
        // ます5を飛ばす様にする。
        events[5].action = HSEraEventReturnSquareAction(title:"",returnSquareCount: 2)
        
        // ます6で所持金が増える。
        events[6].action = HSEraEventMoneyAppendAction(title:"",appendMoneyCount: 1000)
        
        // ます10で所持金が減る。
        events[10].action = HSEraEventMoneyReduceAction(title:"",reduceMoneyCount: 1000)
        
        // ます35でゴールまで飛ばされる。
        events[35].action = HSEraEventSkipSquareAction(title:"",skippableSquareCount: 20)
        
        // ます50でゴールする。
        events[50].action = HSEraEventPlayerGoalAction()
        
        
        events.forEach{eventManager.registerEvent($0)}
        
        return eventManager
    }
    func testActionGoal(){
        let gameController = HSGameController(playerManager: createPlayerManager(), eventManager: createEventManager())
        
        // Aliceがルーレットを回す。
        _=gameController.spinWheel(min:35, max: 35)
        
        XCTAssertEqual(gameController.getPlayerPosition(gameController.currentPlayer), 35)
        
        // ルーレットが回っている後
        gameController.animationDidEnd()
        // 移動通知発火
        
        XCTAssertEqual(gameController.getPlayerPosition(gameController.currentPlayer), 35)
        
        // マス上を動くアニメーショ後
        gameController.animationDidEnd()
        // イベント通知発火
        
        XCTAssertEqual(gameController.getPlayerPosition(gameController.currentPlayer), 35)
        
        // イベントモーダル確認後
        gameController.animationDidEnd()
        // 移動通知発火
        
        XCTAssertEqual(gameController.getPlayerPosition(gameController.currentPlayer), 50)
        
        // マス上を動くアニメーション後
        gameController.animationDidEnd()
        // ゴール通知発火
        
        // ゴールアクション後
        gameController.animationDidEnd()
        // ユーザー変更通知発火
        
        XCTAssertEqual(gameController.currentPlayer.name, "Bob")
    }
    func testEventAction4(){
        let gameController = HSGameController(playerManager: createPlayerManager(), eventManager: createEventManager())
        
        // 確定で10 イベント発生
        _=gameController.spinWheel(min:10, max: 10)
        
        XCTAssertEqual(10,       gameController.getPlayerPosition(gameController.currentPlayer))
        
        gameController.animationDidEnd()
        // イベント着火！1000円減る。0 -> 0
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(0,    gameController.currentPlayer.money)
        XCTAssertEqual(10,     gameController.getPlayerPosition(gameController.currentPlayer))
        
    }
    func testEventAction3(){
        let gameController = HSGameController(playerManager: createPlayerManager(), eventManager: createEventManager())
        
        // 確定で5 イベント発生
        _=gameController.spinWheel(min:6, max: 6)
        
        gameController.animationDidEnd() // ルーレット待機
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(6,       gameController.getPlayerPosition(gameController.currentPlayer))
        
        gameController.animationDidEnd() // 移動待機
        gameController.animationDidEnd() // アクション認証待機
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(1000,    gameController.currentPlayer.money)
        
        gameController.animationDidEnd() // アクションアニメーション待機
        
        XCTAssertEqual("Bob", gameController.currentPlayer.name)
    }
    
    func testEventAction2(){
        let gameController = HSGameController(playerManager: createPlayerManager(), eventManager: createEventManager())
        
        _=gameController.spinWheel(min: 5, max: 5)
        gameController.animationDidEnd() // ルーレット待機
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(5,       gameController.getPlayerPosition(gameController.currentPlayer))
        
        gameController.animationDidEnd() // 移動待機
        gameController.animationDidEnd() // アクション認証待機
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(3,       gameController.getPlayerPosition(gameController.currentPlayer))
        
        gameController.animationDidEnd() // マス移動待機
        
        XCTAssertEqual("Bob", gameController.currentPlayer.name)
    }
    func testEventAction1(){
        let gameController = HSGameController(playerManager: createPlayerManager(), eventManager: createEventManager())
        
        _=gameController.spinWheel(min: 2, max: 2)
        gameController.animationDidEnd() // ルーレット待機
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(2,       gameController.getPlayerPosition(gameController.currentPlayer))
        
        gameController.animationDidEnd() // 移動待機
        gameController.animationDidEnd() // アクション認証待機
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(3,       gameController.getPlayerPosition(gameController.currentPlayer))
        
        gameController.animationDidEnd() // マス移動待機
        
        XCTAssertEqual("Bob", gameController.currentPlayer.name)
        XCTAssertEqual(0,     gameController.getPlayerPosition(gameController.currentPlayer))
    }
    func testPlayerTurn(){
        var counter = 0
        NotificationCenter.default.addObserver(forName: .HSGameControllerDidCurrentPlayerChanged){ notice in
            counter += 1
        }
        let gameController = HSGameController(playerManager: createPlayerManager(), eventManager: createEventManager())
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        
        _=gameController.spinWheel(min: 1, max: 1)
        gameController.animationDidEnd() // ルーレット待機た後
        
        XCTAssertEqual(0,       counter)
        
        gameController.animationDidEnd() // 移動待機後
        
        XCTAssertEqual(1,       counter)
        XCTAssertEqual("Bob", gameController.currentPlayer.name)
    }
}
