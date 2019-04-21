//
//  HSEvent.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
各コマのイベントデータを持ちます。
所持金の増減などのActionも持ちます。
 */
struct HSEraEvent{
    let title:String
    let description:String
    let imageName:String // 画像URLになる...?
    
    let action:HSEraEventAction?
}
