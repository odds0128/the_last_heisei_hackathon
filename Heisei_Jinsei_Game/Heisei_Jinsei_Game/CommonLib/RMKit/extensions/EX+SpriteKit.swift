//
//  EX+SpriteKit.swift
//  Topica
//
//  Created by yuki on 2019/04/09.
//  Copyright © 2019 yuki. All rights reserved.
//

import SpriteKit

//============================================
// SKScene Extensions

extension SKScene{
    /**
     シーンを変更します。transionを設定した場合は、そのtransionに従います。
     */
    func present(to scene: SKScene, transion: SKTransition? = nil){
        if let transion = transion{
            self.view?.presentScene(scene, transition: transion)
        }else{
            self.view?.presentScene(scene)
        }
    }
}
