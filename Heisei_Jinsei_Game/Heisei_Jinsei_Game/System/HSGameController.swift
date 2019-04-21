//
//  HSGameController.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
 HSGameController: ゲームの状況管理をします。
 シングルトンとして、`default`を持ちます。
 */
class HSGameController{
    static let `default` = HSGameController()
    
    private var playerPositions = []
    
    func spinWheel(for player:HSPlayer) {
        
    }
}
