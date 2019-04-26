//
//  HSMapViewController.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

class HSMapViewController: UIViewController {
    
    var basePointX = 30
    var basePointY = 100
    var centerPointX = 53
    var centerPointY = 123
    var nextCenterPointX: Int!
    var nextCenterPointY: Int!
    
    var eventPoint: UIButton!
    var squareButton: UIButton!
    var detailButton: UIButton!
    var menuButton: UIButton!
    var moneyIcon: UIView!
    

    var num = 0
    
    @IBOutlet weak var scrollView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateEventPoint()
        generateSquareButton()
        generateDetailButton()
        generateMenuButton()
        generateMoneyIcon()
        
        
    }
    
    
    //イベントボタン生成
    func generateEventPoint() {
        
        for i in 0..<120 {
            eventPoint = UIButton()
            eventPoint.frame = CGRect(x: basePointX, y: basePointY, width: 60, height: 60)
            eventPoint.backgroundColor = HSColor().blueColor
            eventPoint.layer.cornerRadius = 30
            eventPoint.tag = i
            eventPoint.addTarget(self, action: #selector(eventPointTapped), for: .touchUpInside)
            // 影の設定
            HSShadow.init(layer: eventPoint.layer)
            scrollView.addSubview(eventPoint)
            //画面の端にきたら折り返す
            if (i % 8 == 0 && i != 0) {
                num += 1
            }
            if ((num*8) <= i && i < (num*8)+8) {
                if (num % 2 == 0) {
                    self.basePointX += 80
                    self.basePointY = Int(arc4random(lower: 50, upper: 160)) + (num*200)
                } else {
                    self.basePointX -= 80
                    self.basePointY = Int(arc4random(lower: 50, upper: 160)) + (num*200)
                }
            }
            
            self.nextCenterPointX = basePointX + Int((eventPoint.bounds.width / 2))
            self.nextCenterPointY = basePointY + Int((eventPoint.bounds.height / 2))
            //ラインの描画
            let shapeLayer = CAShapeLayer()
            let path = UIBezierPath()
            path.move(to: CGPoint(x: centerPointX, y: centerPointY))
            path.addLine(to: CGPoint(x: nextCenterPointX, y: nextCenterPointY))
            path.lineWidth = 5
            shapeLayer.lineWidth = 5
            shapeLayer.strokeColor = UIColor.white.cgColor
            shapeLayer.path = path.cgPath
            scrollView.layer.addSublayer(shapeLayer)
            
            self.centerPointX = nextCenterPointX
            self.centerPointY = nextCenterPointY
            
        }
        
    }
    //イベントマスが押されたとき
    @objc func eventPointTapped(_ sender: UIButton) {
        print("タップされた。ButtonTag: \(sender.tag)")
        let actionAlertVC = ActionAlertViewController()
        actionAlertVC.modalPresentationStyle = .overFullScreen
        actionAlertVC.modalTransitionStyle = .crossDissolve
        present(actionAlertVC, animated: true, completion: nil)
        
    }
    
    //マスButton
    func generateSquareButton() {
        squareButton = UIButton()
        squareButton.frame = CGRect(x: 30, y: self.view.bounds.maxY - 80, width: 90, height: 40)
        squareButton.backgroundColor = UIColor(red: 246/255, green: 205/255, blue: 68/255, alpha: 1)
        squareButton.setTitle("マス", for: .normal)
        squareButton.setTitleColor(.white, for: .normal)
        squareButton.titleLabel?.font = UIFont(name: "HiraMaruProN-W4", size: 17)
        
        var familyNames: Array = UIFont.familyNames
        let len = familyNames.count
        
        for i in 0 ..< len {
            let fontFamily = familyNames[i] as String
            let fontNames = UIFont.fontNames(forFamilyName: fontFamily)
            print("\(fontFamily),\(fontNames)")
        }
        let image = UIImage(named: "masu_icon.png")
        squareButton.setImage(image, for: .normal)
        squareButton.imageView?.contentMode = .scaleAspectFit
        squareButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 60)
        squareButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -60, bottom: 0, right: 0)
        squareButton.layer.cornerRadius = 20
        squareButton.layer.shadowOpacity = 0.5
        squareButton.layer.shadowRadius = 3
        squareButton.layer.shadowColor = UIColor.black.cgColor
        squareButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.view.addSubview(squareButton)
    }
    
    //詳細Button
    func generateDetailButton() {
        detailButton = UIButton()
        detailButton.frame = CGRect(x: self.view.bounds.maxX - 110, y: self.view.bounds.maxY - 80, width: 90, height: 40)
        detailButton.backgroundColor = UIColor(red: 49/255, green: 115/255, blue: 246/255, alpha: 1)
        detailButton.setTitle("詳細", for: .normal)
        detailButton.setTitleColor(.white, for: .normal)
        detailButton.titleLabel?.font = UIFont(name: "HiraMaruProN-W4", size: 17)
        detailButton.addTarget(self, action: #selector(generateRoulette), for: .touchUpInside)
        let image = UIImage(named: "detail_icon.png")
        detailButton.setImage(image, for: .normal)
        detailButton.imageView?.contentMode = .scaleAspectFit
        detailButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 60)
        detailButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -40, bottom: 0, right: 0)
        detailButton.layer.cornerRadius = 20
        detailButton.layer.shadowOpacity = 0.5
        detailButton.layer.shadowRadius = 3
        detailButton.layer.shadowColor = UIColor.black.cgColor
        detailButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        let layer = detailButton.layer
        self.view.addSubview(detailButton)
    }
    
    //メニューButton
    func generateMenuButton() {
        menuButton = UIButton()
        menuButton.frame = CGRect(x: 30, y: 50, width: 50, height: 50)
        let image = UIImage(named: "menu_icon.png")
        menuButton.setImage(image, for: .normal)
        menuButton.imageView?.contentMode = .scaleAspectFit
        menuButton.layer.cornerRadius = 20
        menuButton.layer.shadowOpacity = 0.5
        menuButton.layer.shadowRadius = 3
        menuButton.layer.shadowColor = UIColor.black.cgColor
        menuButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.view.addSubview(menuButton)
    }
    
    //所持金ラベルの生成
    func generateMoneyIcon() {
        //        moneyIcon = UIView()
        //        moneyIcon.frame = CGRect(x: self.view.bounds.width - 150, y: 50, width: 50, height: 50)
        //        moneyIcon.backgroundColor = UIColor(red: 249/255, green: 223/255, blue: 75/255, alpha: 1)
        //        moneyIcon.layer.cornerRadius = 25
        let image = UIImage(named: "moneyIndicator.png")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: self.view.bounds.width - 180, y: 30, width: 170, height: 100)
        
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
    }
    
    //範囲指定した間でランダムな数字を返す
    private func arc4random(lower: UInt32, upper: UInt32) -> UInt32 {
        guard upper >= lower else {
            return 0
        }
        
        return arc4random_uniform(upper - lower) + lower
    }
    
    //ルーレットを生成
    @objc private func generateRoulette() {
        blackBackground()
        
        let rouletteView = HSRouletteCustomView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width / 1.7, height: self.view.bounds.width))
        rouletteView.center = self.view.center
        rouletteView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        rouletteView.fadeIn(type: .Normal, completed: nil)
        self.view.addSubview(rouletteView)
    }
    
    //背景を黒く透過する
    func blackBackground() {
        let blackView = UIView(frame: self.view.frame)
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.fadeIn(type: .Normal, completed: nil)
        self.view.addSubview(blackView)
    }
    
}
