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
    /// イベントのタイトルです。
    var title:String
    /// イベントの詳細です。何が起こったかを書いてください。
    var description:String
    /// 画像名です`UIImage(named: ...)`で使います。　　　画像URLになる...?
    var imageName:String
    
    /// マスのアクションです。
    /// あってもなくてもいいです。なければマスが白く、`.bad`ならマスが赤く、`.good`ならマスが緑になります。
    var action:HSEraEventAction?
}
