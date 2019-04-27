//
//  HSMapViewModel.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

class HSMapViewViewModel {
    let gameController: HSGameController
    
    init(players: [HSPlayer], lastSquareIndex: Int) {
        let playerManager = HSPlayerSquareManager(gamingPlayers: players, lastSquareIndex: lastSquareIndex)
        let eventManager = HSSquareEventManager()
        let event = HSEraEvent(title: "テストイベント", heiseiYear: 2019, eventDescription: "テストです", imageName: "car-red", action: nil)
        for i in 0...120 {
            eventManager.registerEvent(event)
        }
        
        
        self.gameController = HSGameController(playerManager: playerManager, eventManager: eventManager)
    }
}
