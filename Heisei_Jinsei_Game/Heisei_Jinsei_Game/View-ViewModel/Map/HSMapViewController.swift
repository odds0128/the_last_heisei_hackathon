//
//  HSMapViewController.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

protocol BalloonViewDelegate {
    func removeBalloonView()
}

protocol RouletteDelegate {
    func endRouletteScene()
}

class HSMapViewController: UIViewController, BalloonViewDelegate, RouletteDelegate {
    
    var basePointX = 150
    var basePointY = 130
    var centerPointX = 185
    var centerPointY = 165
    var nextCenterPointX: Int!
    var nextCenterPointY: Int!
  
    var eventTotalNum = 120
    var eventNumPerLine = 5  ///１行につき5つのイベントマス
    var tempNum = 0
    
    var tappedEventPointX: CGFloat = 0
    var tappedEventPointY: CGFloat = 0
    /// 端末の右側のプレイヤー時の回転
    let rightPlayerTransform = CGAffineTransform(rotationAngle: .pi / -2)
    /// 端末左側のプレイヤー時の回転
    let leftPlayerTransform = CGAffineTransform(rotationAngle: .pi / 2)
    
    var eventPoint: UIButton!
    var eventPointArray = [UIButton]()
    var lineArray = [CAShapeLayer]()
    
    var rouletteView: HSRouletteCustomView!
    var blackView: UIView!
    var balloonView: HSBalloonCustomView!
    
    var playerCars: [Int:Car] = [:]
    var eventPointXArray = [CGFloat]()
    var eventPointYArray = [CGFloat]()
    
    @IBOutlet weak var scrollView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateEventPoint()
        generateRoulette()
        // プレイヤーの車を配置。(TODO:- 全プレイヤーに対応)
        placePlayerCar(playerNum: 1)
        addActionAlertObserver()
    }
    
    ///イベントマスがタップされたとき
    @objc func eventPointTapped(_ sender: UIButton) {
        print("タップされた。ButtonTag: \(sender.tag)")
        /// 検証用コードをコメント化
//         guard let car = playerCars[1] else { return }
//        
//         let range: ClosedRange<Int> = car.currentPosition < sender.tag ?  (car.currentPosition + 1)...(sender.tag) : ((sender.tag)...(car.currentPosition - 1))
//    
//         /// 移動先の座標を詰めていく
//         var positions: [CGPoint] = []
//         for i in range {
//             print(i)
//             guard let moveTo = view.viewWithTag(i) else { return }
//             positions.append(moveTo.frame.origin)
//         }
//         var moveCount = positions.count
//         if car.currentPosition > sender.tag {
//             positions.reverse()
//             moveCount = -moveCount
//         }
//         car.moveTo(positions: positions, moveCount: moveCount, completion: {(true) -> Void in
//             self.generateBalloonView(animationEnded: true)
//         })
    }
    
    ///ルーレットを生成
    @objc private func generateRoulette() {
        blackBackground()
        
        rouletteView = HSRouletteCustomView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width/2.5, height: self.view.bounds.height))
        rouletteView.center = self.view.center
        rouletteView.fadeIn(type: .Normal, completed: nil)
        rouletteView.delegate = self
        self.view.addSubview(rouletteView)
    }
    
    ///ルーレット画面を終了する
    func endRouletteScene() {
        ///1秒処理を遅らせる
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.rouletteView.fadeOut(duration: 0.5, completed: {
                self.rouletteView.removeFromSuperview()
            })
            self.blackView.fadeOut(duration: 0.5, completed: {
                self.blackView.removeFromSuperview()
            })
        }
        
    }
    
    ///背景を黒く透過する
    func blackBackground() {
        blackView = UIView(frame: self.view.frame)
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.fadeIn(type: .Normal, completed: nil)
        self.view.addSubview(blackView)
    }
    
    /// プレイヤーの車を開始地点に配置します。
    ///
    /// - Parameter playerNum: プレイヤーID
    private func placePlayerCar(playerNum: Int) {
        //TODO:- 全ての車の初期化処理. システムマージ後に行う
        let square = view.viewWithTag(1) as! UIButton
        let car = Car(frame: CGRect(x: 0, y: 0, width: 80, height: 60))
        car.configure(carImage: .red)
        scrollView.addSubview(car)
        car.frame.origin = square.frame.origin
        
        /// プレイヤーの車オブジェクトを格納
        let playerCars = [
            playerNum : car
        ]
        self.playerCars = playerCars
    }
    
    ///吹き出しViewを生成
    private func generateBalloonView(animationEnded: Bool) {
        
        let width = self.view.bounds.width/2.8
        let height = self.view.bounds.height/1.8
        print("tappedEventPointY:\(tappedEventPointY)")
        print("view.bounds.height/2:\(view.bounds.height/2)")
        if (tappedEventPointY < view.bounds.height/2) {
            balloonView = HSBalloonCustomView(frame: CGRect(x: tappedEventPointX - width/2, y: tappedEventPointY+50, width:width, height: height))
        } else {
            balloonView = HSBalloonCustomView(frame: CGRect(x: tappedEventPointX - width/2, y: tappedEventPointY-height-50, width:width, height: height))
        }
        
        if (animationEnded == true) {
            balloonView.center = self.view.center
        }
        
        balloonView.fadeIn(duration: 0.3, completed: nil)
        balloonView.delegate = self
        self.view.addSubview(balloonView)
    }
    
    ///BalloonCustomViewのOKボタンが呼ばれたらこれを実行
    func removeBalloonView() {
        self.balloonView.removeFromSuperview()
    }
    
}

///======================================================
///ステージ生成部分(イベントマス、背景、四隅のプレイヤーエリアなど）
///======================================================
extension HSMapViewController {
    
    ///イベントボタン生成
    func generateEventPoint() {
        
        for i in 0..<eventTotalNum {
            eventPoint = UIButton()
            eventPoint.frame = CGRect(x: basePointX, y: basePointY, width: 70, height: 70)
            eventPoint.backgroundColor = HSColor().redColor
            eventPoint.layer.cornerRadius = 35
            eventPoint.layer.borderColor = UIColor.white.cgColor
            eventPoint.layer.borderWidth = 12
            HSShadow.init(layer: eventPoint.layer)
            eventPoint.tag = i + 1
            
            eventPointXArray.append(eventPoint.frame.minX)
            eventPointYArray.append(eventPoint.frame.minY)
            eventPoint.addTarget(self, action: #selector(eventPointTapped), for: .touchUpInside)
            
            eventPoint.longPress(duration: 0.3, { (gesture) in
                
                guard let sender = gesture.view as? UIButton else {
                    print("Sender is not a button")
                    return
                }
                
                switch (gesture.state) {
                case .began:
                    print("longPress start")
                    let location = gesture.location(in: self.view)
                    self.tappedEventPointX = location.x
                    self.tappedEventPointY = location.y
                    print("longPress Location : \(location)")
                    self.generateBalloonView(animationEnded: false)
                case .ended:
                    print("longPress end")
                    self.removeBalloonView()
                default:
                    break
                }
            })
            
            eventPointArray.append(eventPoint)
            ///画面の端にきたら折り返す
            if (i % eventNumPerLine == 0 && i != 0) {
                tempNum += 1
            }
            if ((tempNum*eventNumPerLine) <= i && i < (tempNum*eventNumPerLine)+eventNumPerLine) {
                if (tempNum % 2 == 0) {
                    self.basePointX += 130
                    self.basePointY = Int(arc4random(lower: 40, upper: 180)) + (tempNum*200)
                } else {
                    self.basePointX -= 130
                    self.basePointY = Int(arc4random(lower: 40, upper: 180)) + (tempNum*200)
                }
            }
            
            self.nextCenterPointX = basePointX + Int((eventPoint.bounds.width / 2))
            self.nextCenterPointY = basePointY + Int((eventPoint.bounds.height / 2))
            ///ラインの描画
            let shapeLayer = CAShapeLayer()
            let path = UIBezierPath()
            path.move(to: CGPoint(x: centerPointX, y: centerPointY))
            path.addLine(to: CGPoint(x: nextCenterPointX, y: nextCenterPointY))
            path.lineWidth = 13
            shapeLayer.lineWidth = 13
            shapeLayer.strokeColor = UIColor(white: 1, alpha: 0.5).cgColor
            shapeLayer.path = path.cgPath
            lineArray.append(shapeLayer)
            
            self.centerPointX = nextCenterPointX
            self.centerPointY = nextCenterPointY
            
        }
        
        for i in 0..<lineArray.count {
            scrollView.layer.addSublayer(lineArray[i])
        }
        for i in 0..<eventPointArray.count {
            scrollView.addSubview(eventPointArray[i])
        }
        
    }
    
    ///範囲指定した間でランダムな数字を返す(イベントマス生成用)
    private func arc4random(lower: UInt32, upper: UInt32) -> UInt32 {
        guard upper >= lower else {
            return 0
        }
        return arc4random_uniform(upper - lower) + lower
    }
}
///===============================
///ボタン長押しExtention
///===============================
class GestureClosureSleeve<T: UIGestureRecognizer> {
    let closure: (_ gesture: T)->()
    
    init(_ closure: @escaping (_ gesture: T)->()) {
        self.closure = closure
    }
    
    @objc func invoke(_ gesture: Any) {
        guard let gesture = gesture as? T else { return }
        closure(gesture)
    }
}
extension UIView {
    func longPress(duration: CFTimeInterval, _ closure: @escaping (_ gesture: UILongPressGestureRecognizer)->()) {
        let sleeve = GestureClosureSleeve<UILongPressGestureRecognizer>(closure)
        let recognizer = UILongPressGestureRecognizer(target: sleeve, action: #selector(GestureClosureSleeve.invoke(_:)))
        recognizer.minimumPressDuration = duration
        self.addGestureRecognizer(recognizer)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

// MARK: - アクションアラート
extension HSMapViewController {
    private func addActionAlertObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didEventActionOccured(_:)), name: .HSGameControllerDidEventActionOccur, object: nil)
    }
    
    @objc func didEventActionOccured(_ notification: Notification) {
        let action = notification.object as! HSEraEventAction
        let actionAlertVC = ActionAlertViewController(action: action)
        actionAlertVC.modalPresentationStyle = .overFullScreen
        actionAlertVC.modalTransitionStyle = .crossDissolve
        present(actionAlertVC, animated: true, completion: nil)
    }
}
