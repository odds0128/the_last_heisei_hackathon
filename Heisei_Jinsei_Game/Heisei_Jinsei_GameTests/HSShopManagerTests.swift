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
        let playerManager = HSPlayerSquareManager(gamingPlayers: [alice, bob, cathey])
        
        return playerManager
    }
    
    func createEventManager() -> HSSquareEventManager {
        let eventManager = HSSquareEventManager()
        
        var events = (0...50).map{i in
            HSEraEvent(title: "マス\(i)", heiseiYear: (i/4), eventDescription: "説明", imageName: "nil", action: nil)
        }
        events[4].action = HSEraEventMoneyAppendAction(appendMoneyCount: 1200)
        events.forEach(eventManager.registerEvent)
        
        return eventManager
    }
    
    func testEventMoney(){
        let eventManager = createEventManager()
        let playerManager = createPlayerManager()
        
        let shopManager = HSShopManager(playerManager: playerManager, eventManager: eventManager)
        let gameManager = HSGameController(playerManager: playerManager, eventManager: eventManager)
        
        gameManager.spinWheel(min: 4, max: 4)
        
        XCTAssertEqual(gameManager.getPlayerPosition(gameManager.currentPlayer), 4)
        XCTAssertEqual(gameManager.currentPlayer, alice)
        XCTAssertEqual(gameManager.currentPlayer.money, 0)
        
        gameManager.didAnimationEnd()
        
        XCTAssertEqual(gameManager.currentPlayer.money, 1200)
        XCTAssertEqual(true, shopManager.canBuyItem(HSItemStack(item: .safe, count: 1), by: alice))
        
        gameManager.didAnimationEnd()
        
        XCTAssertEqual(gameManager.currentPlayer, bob)
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


