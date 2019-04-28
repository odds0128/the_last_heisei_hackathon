//
//  HSRouletteAnimation.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/25.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

class HSRouletteAnimation {
    
    var radian: Double = 0.1
    var slowStartDuration: Double! ///タイマー開始から3秒後に遅くなり始める
    var speed = 1.0
    
    var delegate: RouletteDelegate?
    
    init(sender: UIPanGestureRecognizer, rouletteImageView: UIImageView, rouletteVC: HSRouletteCustomView, delegate: RouletteDelegate, randomNum: Int) {
        
        self.delegate = delegate
        startRoulette(sender, rouletteImageView: rouletteImageView, rouletteVC: rouletteVC, randomNum: randomNum)
    }
    
    ///ルーレットスタート
    func startRoulette(_ sender: Any, rouletteImageView: UIImageView, rouletteVC: HSRouletteCustomView, randomNum: Int) {
        
        ///システム側からの乱数に置換する予定
        slowStartDuration = 2.26 - (0.03 * Double(randomNum))
        print("randomNum : \(randomNum)")
        let userInfo = ["imageView":rouletteImageView, "rouletteVC":rouletteVC]
        let timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerUpdate(_:)), userInfo: userInfo, repeats: true)
        rouletteVC.isRotating = true
    }
    
    ///マイフレーム回転させる
    @objc func timerUpdate(_ sender: Timer) {
        
        let userInfo = sender.userInfo as! [String:UIResponder]
        let rouletteImageView = userInfo["imageView"] as! UIImageView
        let mapVC = userInfo["rouletteVC"] as! HSRouletteCustomView

        let angle:CGFloat = CGFloat((radian * M_PI) / 180.0)
        rouletteImageView.transform = CGAffineTransform(rotationAngle: angle)
        
        if (slowStartDuration > 0) {
            radian += 10
            slowStartDuration -= 0.01
            
        } else {
            radian += 10 * speed
            speed -= 0.005
            if (speed < 0) {
                sender.invalidate()
                mapVC.isRotating = false
                self.delegate?.endRouletteScene()
            }
        }
        
    }
}
