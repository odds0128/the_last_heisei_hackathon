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
    
    init(players: [HSPlayer]) {
        let eventManager = HSSquareEventManager.sampleEventManager
        let playerManager = HSPlayerSquareManager(gamingPlayers: players, lastSquareIndex: eventManager.getAllEraEvents().count)
        
        self.gameController = HSGameController(playerManager: playerManager, eventManager: eventManager)
    }
}
