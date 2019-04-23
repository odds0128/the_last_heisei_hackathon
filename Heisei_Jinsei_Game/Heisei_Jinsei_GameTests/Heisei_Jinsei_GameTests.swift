//
//  Heisei_Jinsei_GameTests.swift
//  Heisei_Jinsei_GameTests
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import XCTest
@testable import Heisei_Jinsei_Game

class Heisei_Jinsei_GameTests: XCTestCase {
    override func setUp() {
        let event1 = HSEraEvent(title: "タイトル1", description: "説明", imageName: "nil", action: nil)
        let event2 = HSEraEvent(title: "タイトル2", description: "説明", imageName: "nil", action: nil)
        let event3 = HSEraEvent(title: "タイトル3", description: "説明", imageName: "nil", action:
            HSEraEventSkipSquareAction(skippableSquareCount: 1)
        )
        let event4 = HSEraEvent(title: "タイトル4", description: "説明", imageName: "nil", action: nil)
        let event5 = HSEraEvent(title: "タイトル5", description: "説明", imageName: "nil", action: nil)
        
        _HSSquareEventManager.default.registerEvent(event1)
        _HSSquareEventManager.default.registerEvent(event2)
        _HSSquareEventManager.default.registerEvent(event3)
        _HSSquareEventManager.default.registerEvent(event4)
        _HSSquareEventManager.default.registerEvent(event5)
    }
    
    func testEvent(){
        let playerAlice = HSPlayer(name: "Alice")
        let playerBob = HSPlayer(name: "Bob")
        let playerCathey = HSPlayer(name: "Cathey")
        
        let gameController = HSGameController.initiarize(with: [playerAlice, playerBob, playerCathey])
        
        
        let result = gameController.spinWheel(min: 2, max: 2)
        
        XCTAssertEqual(result, 2)
        XCTAssertEqual(gameController.getPlayerPosition(playerAlice), 2)
        
        // ここでマス上を動くアニメーション
        
        gameController.didAnimationEnd()
        
        // ここでアクション発火、また動く
        
        gameController.didAnimationEnd()
        
        XCTAssertEqual(gameController.getPlayerPosition(playerAlice), 3)
    }
}
