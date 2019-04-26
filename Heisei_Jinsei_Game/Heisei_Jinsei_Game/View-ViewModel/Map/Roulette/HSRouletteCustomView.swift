//
//  HSRouletteCustomView.swift
//  Heisei_Jinsei_Game
//
//  Created by coco j on 2019/04/25.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

class HSRouletteCustomView: UIView {
    
    var rouletteImageView: UIImageView!
    var rouletteHandleImageView: UIImageView!
    var panGesture: UIPanGestureRecognizer!
    
    var isRotating: Bool = false
    
    var delegate: RouletteDelegate?
    
    private var viewWidth: CGFloat!
    private var viewHeight: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewWidth = frame.width
        viewHeight = frame.height
        drawRoulette()
        drawInstructLabel()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    //ルーレットを描画
    private func drawRoulette() {
 
        rouletteImageView = UIImageView()
        rouletteImageView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        rouletteImageView.center = self.center
        let rouletteImage = UIImage(named: "no_handle_roulette.png")
        rouletteImageView.image = rouletteImage
        rouletteImageView.contentMode = .scaleAspectFit
        self.addSubview(rouletteImageView)
        
        rouletteHandleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width/2, height: self.bounds.width/2))
        rouletteHandleImageView.center = self.center
        let handleImgae = UIImage(named: "roulette_handle.png")
        rouletteHandleImageView.image = handleImgae
        rouletteHandleImageView.contentMode = .scaleAspectFit
        self.addSubview(rouletteHandleImageView)
        
        //ドラッグを検知する
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragStart(_:)))
        addGestureRecognizer(panGesture)
    }
    
    private func drawInstructLabel() {
        
        let labelView = UIView()
        labelView.frame = CGRect(x: (self.bounds.width) - (self.bounds.width/1.1), y: self.bounds.height/20, width: self.bounds.width/1.2, height: self.bounds.height / 9)
        labelView.backgroundColor = HSColor().redColor
        labelView.layer.cornerRadius = labelView.frame.height / 2
        labelView.layer.borderColor = UIColor.white.cgColor
        labelView.layer.borderWidth = 7
        HSShadow.init(layer: labelView.layer)
        let text = UILabel(frame: CGRect(x: (self.bounds.width) - (self.bounds.width/1.1), y: 0, width: self.bounds.width / 1.5, height: self.bounds.height / 9))
        text.text = "ルーレットを回せ！"
        text.adjustsFontSizeToFitWidth = true
        text.minimumScaleFactor = 0.3
        text.textColor = .white
        text.font = UIFont(name: HSFont().boldFont, size: 40)
        labelView.addSubview(text)
        
        self.addSubview(labelView)
    }
    
    //ルーレットスタート
    @objc private func startRoulette() {
        if (isRotating == false) {
            HSRouletteAnimation(sender: panGesture, rouletteImageView: rouletteImageView, rouletteVC: self, delegate: delegate!)
        } else {
        }
    }
    
    //ドラッグ開始
    @objc private func dragStart(_ sender: UIPanGestureRecognizer) {
        startRoulette()
    }
    
    
}
