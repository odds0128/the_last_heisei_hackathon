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
        
        let playerManager = HSPlayerSquareManager(gamingPlayers: [alice, bob, cathey])
        
        return playerManager
    }
    func createEventManager() -> HSSquareEventManager {
        let eventManager = HSSquareEventManager()
        
        var events = (0...50).map{i in
            HSEraEvent(title: "タイトル1", heiseiYear: (i/4), eventDescription: "説明", imageName: "nil", action: nil)
        }
        // ます2を飛ばす様にする。
        events[2].action = HSEraEventSkipSquareAction(skippableSquareCount: 1)
        
        // ます5を飛ばす様にする。
        events[5].action = HSEraEventReturnSquareAction(returnSquareCount: 2)
        
        // ます6で所持金が増える。
        events[6].action = HSEraEventMoneyAppendAction(appendMoneyCount: 1000)
        
        // ます10で所持金が減る。
        events[10].action = HSEraEventMoneyReduceAction(reduceMoneyCount: 1000)
        
        
        events.forEach{eventManager.registerEvent($0)}
        
        return eventManager
    }
    func testEventAction4(){
        let gameController = HSGameController(playerManager: createPlayerManager(), eventManager: createEventManager())
        
        // 確定で10 イベント発生
        _=gameController.spinWheel(min:10, max: 10)
        
        XCTAssertEqual(10,       gameController.getPlayerPosition(gameController.currentPlayer))
        
        gameController.didAnimationEnd()
        // イベント着火！1000円減る。0 -> 0
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(0,    gameController.currentPlayer.money)
        XCTAssertEqual(10,     gameController.getPlayerPosition(gameController.currentPlayer))
        
    }
    func testEventAction3(){
        let gameController = HSGameController(playerManager: createPlayerManager(), eventManager: createEventManager())
        
        // 確定で5 イベント発生
        _=gameController.spinWheel(min:6, max: 6)
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(6,       gameController.getPlayerPosition(gameController.currentPlayer))
        
        gameController.didAnimationEnd()
        // イベント着火！1000円える。
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(1000,    gameController.currentPlayer.money)
        XCTAssertEqual(6,     gameController.getPlayerPosition(gameController.currentPlayer))
        
        gameController.didAnimationEnd()
        
        XCTAssertEqual("Bob", gameController.currentPlayer.name)
        XCTAssertEqual(0,     gameController.getPlayerPosition(gameController.currentPlayer))
    }
    
    func testEventAction2(){
        let gameController = HSGameController(playerManager: createPlayerManager(), eventManager: createEventManager())
        
        // 確定で5 イベント発生
        _=gameController.spinWheel(min: 5, max: 5)
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(5,       gameController.getPlayerPosition(gameController.currentPlayer))
        
        
        gameController.didAnimationEnd()
        // イベント着火！2ます戻る。
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(3,       gameController.getPlayerPosition(gameController.currentPlayer))
        
        gameController.didAnimationEnd()
        
        XCTAssertEqual("Bob", gameController.currentPlayer.name)
        XCTAssertEqual(0,     gameController.getPlayerPosition(gameController.currentPlayer))
    }
    func testEventAction1(){
        let gameController = HSGameController(playerManager: createPlayerManager(), eventManager: createEventManager())
        
        // 確定で2 イベント発生
        _=gameController.spinWheel(min: 2, max: 2)
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(2,       gameController.getPlayerPosition(gameController.currentPlayer))
        
        gameController.didAnimationEnd()
        // イベント着火！1マス進む
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(3,       gameController.getPlayerPosition(gameController.currentPlayer))
        
        // ターン終了
        gameController.didAnimationEnd()
        
        XCTAssertEqual("Bob", gameController.currentPlayer.name)
        XCTAssertEqual(0,     gameController.getPlayerPosition(gameController.currentPlayer))
    }
    func testPlayerTurn(){
        let gameController = HSGameController(playerManager: createPlayerManager(), eventManager: createEventManager())
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        
        // 確定で1
        _=gameController.spinWheel(min: 1, max: 1)
        
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(1,       gameController.getPlayerPosition(gameController.currentPlayer))
        
        gameController.didAnimationEnd()
        
        XCTAssertEqual("Bob", gameController.currentPlayer.name)
        XCTAssertEqual(0,     gameController.getPlayerPosition(gameController.currentPlayer))
    }
}
