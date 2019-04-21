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
        let playerAlice = HSPlayer(name: "Alice")
        let playerBob = HSPlayer(name: "Bob")
        let playerCathey = HSPlayer(name: "Cathey")
        
        let players = [playerAlice, playerBob, playerCathey]
        HSGameController.initiarize(with: players)
    }
    
    func testGame() {
        print(HSGameController)
        HSGameController.default.spinWheel()
        
        
    }
}
