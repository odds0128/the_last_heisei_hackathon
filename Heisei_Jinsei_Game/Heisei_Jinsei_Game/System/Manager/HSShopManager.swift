//
//  HSShopManager.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/25.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

class HSShopManager {
    
    // MARK: - HSShopManager Methods
    
    /// アイテムをプレイヤーが購入可能かどうかを返します。
    /// 必ずHSShopManager::buy(_:, _;)の前に呼び出してください。
    func canBuyItem(_ itemStack:HSItemStack, by player:HSPlayer) -> Bool{
        return itemStack.totalValue <=  player.money
    }
    
    /// プレイヤーにアイテムを購入させます。
    /// この関数を呼ぶ前に HSShopManager::canBuyItem(_:, _:)を読んで購入可能かどうかを確認してください。
    func buy(_ itemStack:HSItemStack, by player:HSPlayer) {
        guard canBuyItem(itemStack, by: player) else {
            fatalError("ユーザーがアイテムを購入必要な所持金を持っていません。HSShopManager::canBuyItemを呼んで確認してください。")
        }
        
        let existingItemStack = player.currentItems.first(where: {$0.item == itemStack.item})
        
        if let existingItemStack = existingItemStack{
            existingItemStack.count += itemStack.count
        }else{
            player.currentItems.append(itemStack)
        }
        
        player.money -= itemStack.totalValue
        
        NotificationCenter.default.post(name: .HSGameControllerDidPlayerMoneyChanged, object: player)
    }
    
    /// プレイヤーが現在購入可能なアイテムを返しあます。
    func getAviableItems(for player:HSPlayer) -> [HSItem] {
        let position = playerManager.getPosition(of: player)
        let eraEvent = eventManager.getEraEvent(at: position)
        
        return _allShopItem().filter{$0.sellStartingYear <= eraEvent.heiseiYear}
    }
    
    /// プレーヤーマネージャーです。マス目一の管理をします。
    private let playerManager:HSPlayerSquareManager
    
    /// イベントマネージャーです。
    private let eventManager:HSSquareEventManager
    
    init(playerManager:HSPlayerSquareManager, eventManager:HSSquareEventManager) {
        self.playerManager = playerManager
        self.eventManager = eventManager
    }
    
    func _allShopItem() -> [HSItem]{
        return [
            .safe,
        ]
    }
}

