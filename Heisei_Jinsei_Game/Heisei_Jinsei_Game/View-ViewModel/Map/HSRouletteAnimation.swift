//
//  HSRouletteAnimation.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/25.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation
import UIKit

class HSRouletteAnimation {
    
    var radian: Double = 0.1
    var slowStartDuration: Double = 3.0 ///タイマー開始から3秒後に遅くなり始める
    var speed = 1.0
    
    init(rouletteImageView: UIImageView, rouletteStartBtn: UIButton, mapVC: HSMapViewController) {
        startRoulette(rouletteStartBtn, rouletteImageView: rouletteImageView, mapVC: mapVC)
    }
    
    func startRoulette(_ sender: Any, rouletteImageView: UIImageView, mapVC: HSMapViewController) {
        
        let userInfo = ["imageView":rouletteImageView, "mapVC":mapVC]
        let timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerUpdate(_:)), userInfo: userInfo, repeats: true)
        mapVC.isRotating = true
    }
    
    @objc func timerUpdate(_ sender: Timer) {
        
        let userInfo = sender.userInfo as! [String:UIResponder]
        let rouletteImageView = userInfo["imageView"] as! UIImageView
        let mapVC = userInfo["mapVC"] as! HSMapViewController

        let angle:CGFloat = CGFloat((radian * M_PI) / 180.0)
        rouletteImageView.transform = CGAffineTransform(rotationAngle: angle)
        
        if (slowStartDuration > 0) {
            radian += 10
            slowStartDuration -= 0.01
            
        } else {
            radian += 10 * speed
            speed -= 0.005
            print("radian : \(radian)")
            print("speed: \(speed)")
            if (speed < 0) {
                sender.invalidate()
                mapVC.isRotating = false
            }
        }
        
    }
}
