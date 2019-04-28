//
//  HSShopManagerTests.swift
//  Heisei_Jinsei_GameTests
//
//  Created by yuki on 2019/04/25.
//  Copyright © 2019 yuki. All rights reserved.
//

import XCTest
@testable import Heisei_Jinsei_Game

class HSShopManagerTests: XCTestCase {
    let alice = HSPlayer(name: "Alice")
    let bob = HSPlayer(name: "Bob")
    let cathey = HSPlayer(name: "Cathey")
    
    func createPlayerManager() -> HSPlayerSquareManager {
        let playerManager = HSPlayerSquareManager(gamingPlayers: [alice, bob, cathey], lastSquareIndex: 50)
        
        return playerManager
    }
    
    func createEventManager() -> HSSquareEventManager {
        let eventManager = HSSquareEventManager()
        
        var events = (0...50).map{i in
            HSEraEvent(title: "マス\(i)", heiseiYear: (i/4), eventDescription: "説明", imageName: "nil", action: nil)
        }
        events[4].action = HSEraEventMoneyAppendAction(title:"",appendMoneyCount: 1200)
        events.forEach(eventManager.registerEvent)
        
        return eventManager
    }
    
    func testEventMoney(){
        let eventManager = createEventManager()
        let playerManager = createPlayerManager()
        
        let shopManager = HSShopManager(playerManager: playerManager, eventManager: eventManager)
        let gameController = HSGameController(playerManager: playerManager, eventManager: eventManager)
        
        _ = gameController.spinWheel(min: 4, max: 4)
        gameController.animationDidEnd() // ルーレット待機
        
        XCTAssertEqual(4, gameController.getPlayerPosition(gameController.currentPlayer))
        XCTAssertEqual("Alice", gameController.currentPlayer.name)
        XCTAssertEqual(0, gameController.currentPlayer.money)
        
        gameController.animationDidEnd() // 移動待機
        gameController.animationDidEnd() // アクション認証待機
        
        XCTAssertEqual(gameController.currentPlayer.money, 1200)
        XCTAssertEqual(true, shopManager.canBuyItem(HSItemStack(item: .safe, count: 1), by: alice))
        
        gameController.animationDidEnd() // アクション完了待機
        
        XCTAssertEqual(gameController.currentPlayer, bob)
    }
    
    func testMoney(){
        let eventManager = createEventManager()
        let playerManager = createPlayerManager()
        
        let shopManager = HSShopManager(playerManager: playerManager, eventManager: eventManager)
        
        XCTAssertEqual(false, shopManager.canBuyItem(HSItemStack(item: .safe, count: 2), by: alice))
        
        alice.money = 100000
        
        XCTAssertEqual(true, shopManager.canBuyItem(HSItemStack(item: .safe, count: 2), by: alice))
    }
}


