//
//  HSMapViewController.swift
//  Heisei_Jinsei_Game
//
//  Created by yuki on 2019/04/21.
//  Copyright © 2019 yuki. All rights reserved.
//

import UIKit

protocol BalloonViewDelegate :class{
    func removeBalloonView()
}

protocol RouletteDelegate :class{
    func endRouletteScene()
}


protocol PlayerAreaDelegate {
    func generateRoulette() -> Int
    func generateItemView()

}

protocol ItemAlertDelegate {
    func generateItemAlert(row: Int)
}

class HSMapViewController: UIViewController, BalloonViewDelegate, RouletteDelegate, PlayerAreaDelegate, ItemAlertDelegate {
    
    
    let viewModel: HSMapViewViewModel
    
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    
    var basePointX = 150
    var basePointY = 130
    var centerPointX = 185
    var centerPointY = 165
    var nextCenterPointX: Int!
    var nextCenterPointY: Int!
    
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
    var playerAreaView: HSPlayerAreaCustomView!

    var itemView: HSItemCustomView!
    var itemAlertView: HSItemAlert!
    var playerAreaViewArr: [HSPlayer:HSPlayerAreaCustomView] = [:]
    
    var playerCars: [HSPlayer:Car] = [:]
    var eventPointXArray = [CGFloat]()
    var eventPointYArray = [CGFloat]()
    
    var isItemRouletteFlg = false
    
    @IBOutlet weak var scrollView: UIView!
    
    init() {
        let players = [
            HSPlayer(name: "Taro"),
            HSPlayer(name: "Hanako"),
            HSPlayer(name: "Takashi"),
            HSPlayer(name: "Satoshi")
        ]
        self.viewModel = HSMapViewViewModel(players: players)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        let currentItems: [HSItemStack] = [
            HSItemStack.init(item: HSItem.safe, count: 1),
            //            HSItemStack.init(item: HSItem.bit_coin, count: 200),
            //            HSItemStack.init(item: HSItem.psp, count: 1),
            //            HSItemStack.init(item: HSItem.pocket_bell, count: 1)
        ]
        
        let players = [
            HSPlayer(name: "Taro", currentItems: currentItems),
            HSPlayer(name: "Hanako"),
            HSPlayer(name: "Takashi"),
            HSPlayer(name: "Satoshi")
        ]
        self.viewModel = HSMapViewViewModel(players: players)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        generateGrass()

        generateEventPoint()
        generatePlayerArea()
        
        // プレイヤーの車を配置.
        placePlayerCar(players: viewModel.gameController.gamingPlayers)
        addCarAnimationObserver()
        addActionAlertObserver()
        addRouletteChangingObserver()
        disableOthersRouletteBtn()
    }
    
    ///イベントマスがタップされたとき
    @objc func eventPointTapped(_ sender: UIButton) {
        print("タップされた。ButtonTag: \(sender.tag)")
        
    }
    
    /// 背景の草を生成wwwww
    func generateGrass(){
        self.scrollView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "map_background_grass"))
    }
    
    ///ルーレットを生成
    @objc func generateRoulette() -> Int {
        blackBackground()
        
        rouletteView = HSRouletteCustomView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width/2.5, height: self.view.bounds.height))
        rouletteView.center = self.view.center
        rouletteView.fadeIn(type: .Normal, completed: nil)
        rouletteView.delegate = self
        let randomNum = self.viewModel.gameController.spinWheel()
        rouletteView.randomNum = randomNum
        self.view.addSubview(rouletteView)
        return randomNum
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
    private func placePlayerCar(players: [HSPlayer]) {
        // 全ての車の初期化処理. システムマージ後に行う. 暫定的に色等決め打ち
        let firstSquare = view.viewWithTag(1) as! UIButton
        let firstSquarePoint = firstSquare.frame.origin
        let car = Car(frame: CGRect(origin: firstSquarePoint, size: CGSize(width: 80, height: 60)), carImage: .red)
        let car2 = Car(frame: CGRect(origin: firstSquarePoint, size: CGSize(width: 80, height: 60)), carImage: .blue)
        let car3 = Car(frame: CGRect(origin: firstSquarePoint, size: CGSize(width: 80, height: 60)), carImage: .green)
        let car4 = Car(frame: CGRect(origin: firstSquarePoint, size: CGSize(width: 80, height: 60)), carImage: .yellow)
        scrollView.addSubview(car)
        scrollView.addSubview(car2)
        scrollView.addSubview(car3)
        scrollView.addSubview(car4)
        let cars = [
            car,
            car2,
            car3,
            car4
        ]
        
        let zipped = zip(players, cars)
        self.playerCars = Dictionary(uniqueKeysWithValues: zipped)
    }
    
    ///吹き出しViewを生成
    private func generateBalloonView(animationEnded: Bool, squarePosition: Int) {
        
        guard let event = viewModel.gameController.getEraEvent(at: squarePosition) else { return }
        let width = self.view.bounds.width/2.8
        let height = self.view.bounds.height/1.8
        if (tappedEventPointY < view.bounds.height/2) {
            balloonView = HSBalloonCustomView(frame: CGRect(x: tappedEventPointX - width/2, y: tappedEventPointY+50, width:width, height: height), event: event)
        } else {
            balloonView = HSBalloonCustomView(frame: CGRect(x: tappedEventPointX - width/2, y: tappedEventPointY-height-50, width:width, height: height), event: event)
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
        self.viewModel.gameController.animationDidEnd()
    }
    
}

///======================================================
///ステージ生成部分(イベントマス、背景、四隅のプレイヤーエリアなど）
///======================================================
extension HSMapViewController {
    
    ///イベントボタン生成
    func generateEventPoint() {
        
        for (i, event) in viewModel.gameController.getAllEraEvents().enumerated() {
            eventPoint = UIButton()
            eventPoint.frame = CGRect(x: basePointX, y: basePointY, width: 70, height: 70)
            /// イベントのアクションによってマスの色を変える
            switch event.action {
            case .none:
                eventPoint.backgroundColor = .white
            case .some(let action):
                switch action.eventType {
                case .good:
                    eventPoint.backgroundColor = HSColor().greenColor
                case .bad:
                    eventPoint.backgroundColor = HSColor().redColor
                case .goal:
                    break
                case .special:
                    break
                }
            }
            eventPoint.layer.cornerRadius = 35
            eventPoint.layer.borderColor = UIColor.white.cgColor
            eventPoint.layer.borderWidth = 12
            HSShadow.makeShadow(to: eventPoint.layer)
            eventPoint.tag = i + 1
            
            eventPointXArray.append(eventPoint.frame.minX)
            eventPointYArray.append(eventPoint.frame.minY)
            eventPoint.addTarget(self, action: #selector(eventPointTapped), for: .touchUpInside)
            
            eventPoint.longPress(duration: 0.3, { (gesture) in
                
                guard let sender = gesture.view as? UIButton else {
                    return
                }
                switch (gesture.state) {
                case .began:
                    let location = gesture.location(in: self.view)
                    self.tappedEventPointX = location.x
                    self.tappedEventPointY = location.y
                    self.generateBalloonView(animationEnded: false, squarePosition: sender.tag - 1)
                case .ended:
                    // ビューだけを消す
                    self.balloonView.fadeOut(duration: 0.3) { [weak self] in
                        self?.balloonView.removeFromSuperview()
                    }
                    self.balloonView.removeFromSuperview()
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
    
    ///プレイヤーエリアの生成
    private func generatePlayerArea() {
        let playerAreaWidth = self.view.frame.width/4
        let playerAreaHeight = self.view.frame.width/4
        
        let players = viewModel.gameController.gamingPlayers
        setPlayerArea(x: -playerAreaWidth/2.55, y: self.view.frame.height - playerAreaHeight/1.3, radian: 45, player: players[0])
        setPlayerArea(x: -playerAreaWidth/2.55, y: -playerAreaHeight/2.55, radian: 135, player: players[1])
        setPlayerArea(x: self.view.frame.width - playerAreaWidth/1.3, y: -playerAreaHeight/2.55, radian: -135, player: players[2])
        setPlayerArea(x: self.view.frame.width - playerAreaWidth/1.3, y: self.view.frame.height - playerAreaHeight/1.3, radian: -45, player: players[3])
    }
    ///プレイヤーエリアのセット
    private func setPlayerArea(x: CGFloat, y: CGFloat, radian: Double, player: HSPlayer) {
        let frame = CGRect(x: x, y: y, width: self.view.bounds.width/3.5, height: self.view.bounds.width/3.5)
        let name = player.name
        let money = player.money
        playerAreaView = HSPlayerAreaCustomView(frame: frame, name: name, money: money)
        let angle = CGFloat((radian * .pi) / 180.0)
        playerAreaView.transform = CGAffineTransform(rotationAngle: angle)
        playerAreaView.delegate = self
        self.playerAreaViewArr[player] = self.playerAreaView
        self.view.addSubview(playerAreaView)
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

///===============================
///アイテム系Extension
///===============================
extension HSMapViewController {
    
    ///アイテム欄の生成
    func generateItemView() {
        let width = view.frame.width/1.5
        let height = view.frame.height/2
        let name = viewModel.gameController.currentPlayer.name
        let items = viewModel.gameController.currentPlayer.currentItems
        let frame = CGRect(x: view.frame.width/2-width/2, y: view.frame.height, width: width, height: height)
        itemView = HSItemCustomView(frame: frame, name: name, items: items)
        HSShadow.init(layer: itemView.layer, offset: CGSize.zero, opacity: 3, radius: 10)
        itemView.layer.cornerRadius = 50
        itemView.delegate = self
        itemView.closeButton.addTarget(self, action: #selector(closeItemView), for: .touchUpInside)
        view.addSubview(itemView)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.itemView.frame.origin.y -= height
        }, completion: nil)
    }
    
    ///アイテム使用アラートの生成
    func generateItemAlert(row: Int) {
        print("itemBtntapped")
        let frame = CGRect(x: 0, y: 0, width: viewWidth/2.5, height: viewWidth/2.5)
        itemAlertView = HSItemAlert(frame: frame)
        itemAlertView.center = self.view.center
        itemAlertView.backgroundColor = .white
        itemAlertView.layer.cornerRadius = 30
        print("row: \(row)")
        print("currentItems:\(viewModel.gameController.currentPlayer.name)")
        let item: HSItemStack = viewModel.gameController.currentPlayer.currentItems[row]
        print("item: \(item)")
        itemAlertView.item = item
        itemAlertView.itemOKBtn.addTarget(self, action: #selector(itemOKBtnTapped), for: .touchUpInside)
        itemAlertView.itemCancelBtn.addTarget(self, action: #selector(itemCancelBtnTapped), for: .touchUpInside)
        blackBackground()
        itemAlertView.setupItemAlert()
        self.view.addSubview(itemAlertView)
    }
    
    @objc func closeItemView() {
        print("閉じる")
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            self.itemView.frame.origin.y = self.view.frame.height
        }, completion: nil)
    }
    
    
    @objc func itemOKBtnTapped(_ sender: UIButton) {
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.itemAlertView.fadeOut(duration: 0.2, completed: {
                self.itemAlertView.removeFromSuperview()
                //self.generateItemView()
                self.isItemRouletteFlg = true
                let randomNum = self.generateRoulette()
                
                let currentPlayer = self.viewModel.gameController.currentPlayer
                print("randomNum: \(randomNum)")
                currentPlayer.currentItems[sender.tag].item.function(currentPlayer, randomNum) { [weak self] in
                    currentPlayer.currentItems.remove(at: sender.tag)
                }
            })
            self.blackView.fadeOut(duration: 0.2, completed: {
                self.blackView.removeFromSuperview()
                self.closeItemView()
            })
        }
    }
    
    @objc func itemCancelBtnTapped() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.itemAlertView.fadeOut(duration: 0.2, completed: {
                self.itemAlertView.removeFromSuperview()
                
            })
            self.blackView.fadeOut(duration: 0.2, completed: {
                self.blackView.removeFromSuperview()
            })
        }
    }
    
    
=======
// MARK: - 金額変更アニメーション
extension HSMapViewController {
    func addMoneyChangingObserver(){
        NotificationCenter.default.addObserver(forName: .HSGameControllerDidPlayerMoneyChanged){[weak self] notice in
            guard let player = notice.object as? HSPlayer else {return}
            self?.didPlayerMoneyChanged(player: player)
        }
    }
    func didPlayerMoneyChanged(player:HSPlayer){
        let playerArea = playerAreaViewArr[viewModel.gameController.getPlayerIndex(player)]
        playerArea.setMoney(player.money)
        viewModel.gameController.animationDidEnd()
    }
}

// MARK: - 車移動アニメーション
extension HSMapViewController {
    /// 車移動アニメーションのオブザーバーを登録する
    func addCarAnimationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didPlayerPositionChanged(_:)), name: .HSGameControllerDidPlayerPositionChanged, object: nil)
    }
    
    @objc func didPlayerPositionChanged(_ notification: Notification) {
        /// プレイヤーの移動後の一取得
        let player = notification.object as! HSPlayer
        let toPosition = viewModel.gameController.getPlayerPosition(player) + 1
        guard let car = playerCars[player] else { return }
        
        let range: ClosedRange<Int> = car.currentPosition < toPosition ? (car.currentPosition + 1)...(toPosition) : ((toPosition)...(car.currentPosition - 1))
        
        /// 移動先の座標を詰めていく
        var positions: [CGPoint] = []
        for i in range {
            guard let moveTo = view.viewWithTag(i) else { return }
            positions.append(moveTo.frame.origin)
        }
        var moveCount = positions.count
        if car.currentPosition > toPosition {
            positions.reverse()
            moveCount = -moveCount
        }
        /// 移動処理
        car.moveTo(positions: positions, moveCount: moveCount, completion: {[weak self] (true) -> Void in
            /// 移動完了時吹き出しを出す
            self?.generateBalloonView(animationEnded: true, squarePosition: toPosition)
        })
    }
}

// MARK: - アクションアラート
extension HSMapViewController:ActionAlertViewControllerBinder {
    private func addActionAlertObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didEventActionOccured(_:)), name: .HSGameControllerDidEventActionOccur, object: nil)
    }
    func endActionAlertView() {
        self.viewModel.gameController.animationDidEnd()
    }
    
    @objc func didEventActionOccured(_ notification: Notification) {
        let action = notification.object as! HSEraEventAction
        let actionAlertVC = ActionAlertViewController(binder: self,action: action)
        actionAlertVC.modalPresentationStyle = .overFullScreen
        actionAlertVC.modalTransitionStyle = .crossDissolve
        present(actionAlertVC, animated: true, completion: nil)
    }
}


//MARK: - ルーレット
extension HSMapViewController {
    ///手番更新時に呼ばれる
    private func addRouletteChangingObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(disableOthersRouletteBtn), name: .HSGameControllerDidCurrentPlayerChanged, object: nil)
    }
    ///ルーレット画面を終了する
    @objc func endRouletteScene() {
        ///1秒処理を遅らせる
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.rouletteView.fadeOut(duration: 0.5, completed: {
                self.rouletteView.removeFromSuperview()
                if (self.isItemRouletteFlg == false) {
                    self.viewModel.gameController.animationDidEnd()
                } else {
                    let currentPlayer = self.viewModel.gameController.currentPlayer
                    self.playerAreaViewArr[currentPlayer]!.moneyLabel.text = "¥\(currentPlayer.money)"
                }
            })
            self.blackView.fadeOut(duration: 0.5, completed: {
                self.blackView.removeFromSuperview()
            })
        }
    }
    
    ///手番ではないプレイヤーのルーレットボタンをタップできないようにする
    @objc func disableOthersRouletteBtn() {
        let currentPlayer = viewModel.gameController.currentPlayer
        let currentPlayerIndex = viewModel.gameController.getPlayerIndex(currentPlayer)
        for i in 0..<4 {
            if (currentPlayerIndex != i) {
                playerAreaViewArr[i].disableRouletteBtn()
            }
            if (currentPlayerIndex == i) {
               playerAreaViewArr[i].enableRouletteBtn()
            }
        }
    }
}
